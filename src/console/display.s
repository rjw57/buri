; Console output support
.include "macros.inc"

.importzp tmp1, sp, ptr1
.import vdp_set_write_addr, vdp_set_read_addr, vdp_tick
.import VDP_NAM_TBL_BASE, VDP_DATA

CONSOLE_COLS = 40
CONSOLE_ROWS = 24

; When scrolling, CONSOLE_BLOCK_LEN specifies the number of bytes read from and
; written to VRAM as one block. It should be a factor of CONSOLE_COLS. It also
; shouldn't be too big because the C stack is used as temporary storage and
; overflowing the stack is Bad News.
CONSOLE_BLOCK_LEN = 8

; =========================================================================
; Zero page global variables
; =========================================================================
.segment "OSZP": zeropage

; Current row and column position of console cursor. The cursor is the location
; on screen where the next character will be printed.
console_cursor_col: .res 1
console_cursor_row: .res 1
.exportzp console_cursor_col, console_cursor_row

.bss

console_cursor_vram_addr: .res 2

.code

; =========================================================================
; console_cursor_recalc: recalculate cursor VRAM address
; =========================================================================
.export console_cursor_recalc
.proc console_cursor_recalc
        ldy console_cursor_col          ; Y = col
        ldx console_cursor_row          ; X = row

        m16                             ; Compute 16-bit offset in A
        tya                             ; A = VDP_NAM_TBL_BASE + Y
        add #VDP_NAM_TBL_BASE

@loop:                                  ; A += CONSOLE_COLS * X
        cpx #0
        beq @endloop
        add #CONSOLE_COLS
        dex
        bra @loop
@endloop:

        sta console_cursor_vram_addr
        m8                              ; Back to 8-bit A
        rts
.endproc

; =========================================================================
; console_idle: idle handler
;
; C: void console_idle(void)
; =========================================================================
.export console_idle
.proc console_idle
        lda vdp_tick
        and #$10
        beq tock
        bra end
tock:
end:

        rts
.endproc
.export _console_idle := console_idle

; =========================================================================
; console_cursor_set: move text mode cursor
;       A - column for cursor
;       X - row for cursor
;
; C: void console_cursor_set(u8 col, u8 row)
; =========================================================================
.export console_cursor_set
.proc console_cursor_set
        cmp #CONSOLE_COLS               ; clamp cols
        blt @cols_ok                    ; cols < CONSOLE_COLS?
        lda #CONSOLE_COLS
        dec
@cols_ok:
        cpx #CONSOLE_ROWS               ; clamp rows
        blt @rows_ok                    ; rows < CONSOLE_ROWS?
        ldx #CONSOLE_ROWS
        dex
@rows_ok:

        sta console_cursor_col
        stx console_cursor_row
        jmp console_cursor_recalc       ; tail call
.endproc

; C fastcall thunk for console_cursor_set
.export _console_cursor_set
.proc _console_cursor_set
        tax                             ; X <- rightmost argument
        ldy #0
        lda (sp),Y                      ; A <- first value on stack
        jmp console_cursor_set
.endproc

; =========================================================================
; console_cursor_clear: clear cursor from output
; =========================================================================
.proc console_cursor_clear
        lda console_cursor_vram_addr
        ldx console_cursor_vram_addr+1
        jsr vdp_set_write_addr
        lda #' '
        sta VDP_DATA
        rts
.endproc

; =========================================================================
; console_cursor_draw: draw cursor on screen
; =========================================================================
.proc console_cursor_draw
        lda console_cursor_vram_addr
        ldx console_cursor_vram_addr+1
        jsr vdp_set_write_addr
        lda #'_'
        sta VDP_DATA
        rts
.endproc

; =========================================================================
; console_write_char: write character to console
;       A - byte to write
;
; C: void console_write_char(u8 ch)
; =========================================================================
.export console_write_char
.proc console_write_char
        cmp #$0A                        ; ASCII line feed
        beq console_cursor_down

        cmp #$0D                        ; ASCII carriage return
        bne nocr
        lda #$00
        ldx console_cursor_row
        bra console_cursor_set
nocr:

        pha                             ; save character
        lda console_cursor_vram_addr
        ldx console_cursor_vram_addr+1
        jsr vdp_set_write_addr
        pla                             ; restore character
        sta VDP_DATA                    ; write character
        bra console_cursor_right        ; advance cursor (tail call)
.endproc
.export _console_write_char := console_write_char

; =========================================================================
; console_cursor_right: move cursor to the right one position
;
; This will scroll the console if the cursor goes off the screen
; =========================================================================
.proc console_cursor_right
        inc console_cursor_col          ; common-case

        lda console_cursor_col          ; if cols < CONSOLE_COLS, exit
        cmp #CONSOLE_COLS
        blt exit

        stz console_cursor_col          ; move to next row instead
        bra console_cursor_down
exit:
        jmp console_cursor_recalc
.endproc

; =========================================================================
; console_cursor_down: move cursor down one position
;
; This will scroll the console if the cursor goes off the screen
; =========================================================================
.proc console_cursor_down
        inc console_cursor_row
        lda console_cursor_row          ; if rows < CONSOLE_ROWS, exit
        cmp #CONSOLE_ROWS
        blt exit

        ; We now enter the rare case where the cursor has gone off the bottom
        ; right of the screen. Undo our increment of row and instead scroll the
        ; screen
        dec console_cursor_row
        jsr console_scroll_up
exit:
        jmp console_cursor_recalc
.endproc

; =========================================================================
; console_scroll_up: scrolls console screen up by one row
;
; Note: this does not change the cursor position
; =========================================================================
.export console_scroll_up
.proc console_scroll_up
        ; Set Y to number of 8 byte copies required to scroll screen.
        ldy #(CONSOLE_COLS*(CONSOLE_ROWS-1))/CONSOLE_BLOCK_LEN

        m16                             ; ptr1 = VDP_NAM_TBL_BASE
        lda #VDP_NAM_TBL_BASE
        sta ptr1
        m8

@loop:                                  ; copy loop
        phy                             ; save Y
        lda ptr1                        ; load destn. address
        ldx ptr1+1
        jsr console_copy_up             ; copy

        m16                             ; ptr1 += 8
        lda ptr1
        add #CONSOLE_BLOCK_LEN
        sta ptr1
        m8

        ply                             ; restore Y
        dey
        bne @loop

        m16                             ; ptr1 = start of last row
        lda #VDP_NAM_TBL_BASE + (CONSOLE_COLS*(CONSOLE_ROWS-1))
        sta ptr1
        m8

        lda ptr1                        ; start writing last row
        ldx ptr1+1
        jsr vdp_set_write_addr

        ldy #CONSOLE_COLS               ; write CONSOLE_COLS zero bytes
@clear_loop:
        stz VDP_DATA
        dey
        bne @clear_loop

        rts
.endproc

; =========================================================================
; console_copy_up: copy 8 bytes from VRAM one row up
;       A - low byte VRAM address of *destination*
;       X - high byte VRAM address of *destination*
;
; Letting addr be the 16-bit VRAM address, copies CONSOLE_BLOCK_LEN bytes from
; VRAM address addr + CONSOLE_COLS to addr.
; =========================================================================
.proc console_copy_up
        sta ptr1                        ; ptr1 = destn. address
        stx ptr1+1

        m16                             ; 16-bit accumulator
        lda sp                          ; sp -= CONSOLE_BLOCK_LEN
        sub #CONSOLE_BLOCK_LEN
        sta sp

        lda ptr1                        ; A = VRAM addr
        add #CONSOLE_COLS               ; A += CONSOLE_COLS
        m8                              ; 8-bit accumulator

        xba                             ; High-byte -> X
        tax
        xba                             ; Low-byte -> A
        jsr vdp_set_read_addr

        ldy #CONSOLE_BLOCK_LEN-1        ; Read CONSOLE_BLOCK_LEN bytes
@readloop:
        lda VDP_DATA                    ; sp[i] = *VDP_DATA
        sta (sp), Y
        dey
        bpl @readloop

        lda ptr1                        ; Restore low byte of destn.
        ldx ptr1+1                      ; Restore high byte of destn.
        jsr vdp_set_write_addr          ; Set VRAM write detn.

        ldy #CONSOLE_BLOCK_LEN-1        ; Write CONSOLE_BLOCK_LEN bytes
@writeloop:
        lda (sp), Y                     ; *VDP_DATA = sp[i]
        sta VDP_DATA
        dey
        bpl @writeloop

        m16                             ; 16-bit accumulator
        lda sp                          ; sp += CONSOLE_BLOCK_LEN
        add #CONSOLE_BLOCK_LEN
        sta sp
        m8                              ; 8-bit accumulator

        rts                             ; Exit
.endproc
