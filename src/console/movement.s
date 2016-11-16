; Console cursor movement
.include "macros.inc"

.importzp sp, ptr1
.import vdp_set_write_addr, vdp_set_read_addr
.import VDP_NAM_TBL_BASE, VDP_DATA

.importzp console_cursor_col, console_cursor_row
.import console_cursor_vram_addr, console_cursor_erase, console_cursor_draw

CONSOLE_COLS = 40
CONSOLE_ROWS = 24

; When scrolling, CONSOLE_BLOCK_LEN specifies the number of bytes read from and
; written to VRAM as one block. It should be a factor of CONSOLE_COLS. It also
; shouldn't be too big because the C stack is used as temporary storage and
; overflowing the stack is Bad News.
CONSOLE_BLOCK_LEN = 8

.code

; C fastcall thunk for console_cursor_set
.export _console_cursor_set
.proc _console_cursor_set
        tax                             ; X <- rightmost argument
        ldy #0
        lda (sp),Y                      ; A <- first value on stack

        ;We intentionally fall through to console_cursor_set
.endproc

; =========================================================================
; console_cursor_set: move text mode cursor
;       A - column for cursor
;       X - row for cursor
;
; A and X are clamped to the range [0, cols) and [0, rows) respectively.
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

        pha
        phx
        jsr console_cursor_erase
        plx
        pla

        sta console_cursor_col
        stx console_cursor_row
        jsr console_cursor_recalc
        jmp console_cursor_draw         ; tail call
.endproc

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
; console_cursor_left: move cursor to the left one position
; =========================================================================
.export console_cursor_left
.proc console_cursor_left
        jsr console_cursor_erase

        dec console_cursor_col          ; common-case
        m16
        dec console_cursor_vram_addr
        m8

        lda console_cursor_col          ; if cols >= 0, exit
        bmi moveup

exit:
        jsr console_cursor_draw
        rts

moveup:
        lda console_cursor_row          ; check if we're on row 0
        bne notfirstrow

        inc console_cursor_col          ; first row, just do nothing
        m16
        inc console_cursor_vram_addr
        m8
        bra exit

notfirstrow:
        lda #CONSOLE_COLS               ; reset column
        dec
        sta console_cursor_col
        m16                             ; correct VRAM address
        lda console_cursor_vram_addr
        add #CONSOLE_COLS
        sta console_cursor_vram_addr
        m8

        jsr console_cursor_draw

        ; We intentionally fall through to console_cursor_up
.endproc

; =========================================================================
; console_cursor_up: move cursor up one position
; =========================================================================
.export console_cursor_up
.proc console_cursor_up
        jsr console_cursor_erase

        dec console_cursor_row          ; decrement row
        m16                             ; update VRAM address
        lda console_cursor_vram_addr
        sub #CONSOLE_COLS
        sta console_cursor_vram_addr
        m8
        lda console_cursor_row          ; if rows >= 0, exit
        bmi undo

        jsr console_cursor_draw
        rts

undo:
        ; We cannot scroll the screen down so just undo what we did
        inc console_cursor_row
        m16                             ; update VRAM address
        lda console_cursor_vram_addr
        add #CONSOLE_COLS
        sta console_cursor_vram_addr
        m8

        jmp console_cursor_draw         ; tail call
.endproc

; =========================================================================
; console_cursor_right: move cursor to the right one position
;
; This will scroll the console if the cursor goes off the screen
; =========================================================================
.export console_cursor_right
.proc console_cursor_right
        jsr console_cursor_erase

        inc console_cursor_col          ; common-case
        m16
        inc console_cursor_vram_addr
        m8

        lda console_cursor_col          ; if cols < CONSOLE_COLS, exit
        cmp #CONSOLE_COLS
        beq newline

        jsr console_cursor_draw
        rts

newline:
        stz console_cursor_col          ; reset column to zero
        m16                             ; correct VRAM address
        lda console_cursor_vram_addr
        sub #CONSOLE_COLS
        sta console_cursor_vram_addr
        m8

        jsr console_cursor_draw

        ; We intentionally fall through to console_cursor_down
.endproc

; =========================================================================
; console_cursor_down: move cursor down one position
;
; This will scroll the console if the cursor goes off the screen
; =========================================================================
.export console_cursor_down
.proc console_cursor_down
        jsr console_cursor_erase

        inc console_cursor_row          ; increment row
        m16                             ; update VRAM address
        lda console_cursor_vram_addr
        add #CONSOLE_COLS
        sta console_cursor_vram_addr
        m8
        lda console_cursor_row          ; if rows < CONSOLE_ROWS, exit
        cmp #CONSOLE_ROWS
        beq scroll

        jsr console_cursor_draw
        rts

scroll:
        ; We now enter the rare case where the cursor has gone off the bottom
        ; right of the screen. Undo our increment of row and instead scroll the
        ; screen
        dec console_cursor_row
        m16                             ; update VRAM address
        lda console_cursor_vram_addr
        sub #CONSOLE_COLS
        sta console_cursor_vram_addr
        m8

        jsr console_scroll_up
        jmp console_cursor_draw         ; tail call
.endproc

; =========================================================================
; console_scroll_up: scrolls console screen up by one row
;
; Note: this does not change the cursor position
; =========================================================================
.export console_scroll_up
.proc console_scroll_up
        ; Set Y to number of block copies required to scroll screen.
        ldy #(CONSOLE_COLS*(CONSOLE_ROWS-1))/CONSOLE_BLOCK_LEN

        m16                             ; ptr1 = VDP_NAM_TBL_BASE
        lda #VDP_NAM_TBL_BASE
        sta ptr1
        m8

@loop:                                  ; copy loop
        phy                             ; save Y
        lda ptr1                        ; load destn. address
        ldx ptr1+1
        pha
        phx
        jsr console_copy_up             ; copy
        plx
        pla
        sta ptr1
        stx ptr1+1

        m16                             ; ptr1 += block length
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

