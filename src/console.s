; Simple console driver using VDP
.include "macros.inc"

.importzp tmp1, sp, ptr1
.import vdp_set_write_addr, vdp_set_read_addr
.import VDP_NAM_TBL_BASE, VDP_DATA

CONSOLE_COLS = 40
CONSOLE_ROWS = 24

; When scrolling, CONSOLE_BLOCK_LEN specifies the number of bytes read from and
; written to VRAM as one block. It should be a factor of CONSOLE_COLS. It also
; shouldn't be too big because the C stack is used as temporary storage and
; overflowing the stack is Bad News.
CONSOLE_BLOCK_LEN = 10

; =========================================================================
; Zero page global variables
; =========================================================================
.segment "OSZP": zeropage

; Current row and column position of console cursor. The cursor is the location
; on screen where the next character will be printed.
console_cursor_col: .res 1
console_cursor_row: .res 1
.exportzp console_cursor_col, console_cursor_row

.code

; =========================================================================
; console_init: initialise console driver
;
; requires: vdp_init called
;
; C: void console_init(void)
; =========================================================================
.export console_init
.proc console_init
        lda #0
        ldx #0
        jmp console_cursor_set

        rts
.endproc
.export _console_init := console_init

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
        bcc @cols_ok                    ; cols < CONSOLE_COLS?
        lda #CONSOLE_COLS-1
@cols_ok:
        cpx #CONSOLE_ROWS               ; clamp rows
        bcc @rows_ok                    ; rows < CONSOLE_ROWS?
        ldx #CONSOLE_ROWS-1
@rows_ok:

        sta console_cursor_col
        stx console_cursor_row

        tay                             ; Y <- columns

        m16                             ; Compute 16-bit offset in A
        lda #VDP_NAM_TBL_BASE           ; A = VDP_NAM_TBL_BASE
        sty tmp1
        add tmp1                        ; A += Y

@loop:                                  ; A += CONSOLE_COLS * X
        cpx #0
        beq @endloop
        add #CONSOLE_COLS
        dex
        bra @loop
@endloop:

        m8                              ; Back to 8-bit A

        xba                             ; High-byte of VRAM address -> A
        tax                             ; High-byte of VRAM address -> X
        xba                             ; Low-byte of VRAM address -> A

        jmp vdp_set_write_addr          ; Update VRAM address (tail call)
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
; console_write_char: write character to console
;       A - byte to write
;
; C: void console_write_char(u8 ch)
; =========================================================================
.export console_write_char
.proc console_write_char
        ldx console_cursor_col          ; Advance cursor column
        cpx #CONSOLE_COLS-1
        bcc @col_ok                     ; column < CONSOLE_COLS-1?
        ldx console_cursor_row
        cpx #CONSOLE_ROWS-1
        bcs @need_scroll                ; row >= CONSOLE_ROWS-1?
        inx
        stx console_cursor_row
        stz console_cursor_col
        bra @done
@need_scroll:
        pha
        jsr console_scroll_up
        lda #0
        ldx #CONSOLE_ROWS-1
        jsr console_cursor_set
        pla
        bra @done
@col_ok:
        inx
        stx console_cursor_col
@done:
        sta VDP_DATA
        rts
.endproc
.export _console_write_char := console_write_char

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
