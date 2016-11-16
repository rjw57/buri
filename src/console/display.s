; Console output support
.include "macros.inc"

.import vdp_set_write_addr, vdp_set_read_addr, vdp_tick
.import VDP_DATA

.importzp console_cursor_col, console_cursor_row
.import console_cursor_save, console_cursor_char, console_cursor_vram_addr
.import console_cursor_right, console_cursor_down, console_cursor_set
.import console_cursor_left

CONSOLE_COLS = 40
CONSOLE_ROWS = 24

; When scrolling, CONSOLE_BLOCK_LEN specifies the number of bytes read from and
; written to VRAM as one block. It should be a factor of CONSOLE_COLS. It also
; shouldn't be too big because the C stack is used as temporary storage and
; overflowing the stack is Bad News.
CONSOLE_BLOCK_LEN = 8

.code

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
tick:
        lda #' '
        bra setcc
tock:
        lda #'_'
setcc:
        jsr console_set_cursor_char

        rts
.endproc
.export _console_idle := console_idle

; =========================================================================
; console_cursor_erase: restore saved character under cursor
;
; Removes the cursor from the screen restoring the character saved in
; console_cursor_draw
; =========================================================================
.export console_cursor_erase
.proc console_cursor_erase
        lda console_cursor_vram_addr
        ldx console_cursor_vram_addr+1
        jsr vdp_set_write_addr
        lda console_cursor_save
        sta VDP_DATA
        rts
.endproc

; =========================================================================
; console_cursor_draw: draw cursor on screen
;
; The character at the cursor position is saved and can be restored via
; console_cursor_erase.
; =========================================================================
.export console_cursor_draw
.proc console_cursor_draw
        lda console_cursor_vram_addr
        ldx console_cursor_vram_addr+1
        jsr vdp_set_read_addr
        lda VDP_DATA
        sta console_cursor_save

        lda console_cursor_vram_addr
        ldx console_cursor_vram_addr+1
        jsr vdp_set_write_addr
        lda console_cursor_char
        beq nodraw
        sta VDP_DATA
nodraw:
        rts
.endproc

; =========================================================================
; console_set_cursor_char: set cursor character
;       A - new cursor character
;
; Set character used to display cursor location. Use A == $00 to disable cursor.
; =========================================================================
.export console_set_cursor_char
.proc console_set_cursor_char
        cmp console_cursor_char
        beq exit

        sta console_cursor_char
        jsr console_cursor_erase
        jsr console_cursor_draw
exit:
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
        cmp #$20                        ; printable
        blt noprint
        pha                             ; save character
        jsr console_cursor_erase
        lda console_cursor_vram_addr
        ldx console_cursor_vram_addr+1
        jsr vdp_set_write_addr
        pla                             ; restore character
        sta VDP_DATA                    ; write character
        jsr console_cursor_draw
        jmp console_cursor_right        ; advance cursor (tail call)

noprint:
        cmp #$0A                        ; ASCII line feed
        bne nolf
        jmp console_cursor_down         ; tail-call
nolf:
        cmp #$0D                        ; ASCII carriage return
        bne nocr
        lda #$00
        ldx console_cursor_row
        jmp console_cursor_set          ; tail-call
nocr:
        cmp #$08                        ; ASCII backspace
        bne nobs
        jmp console_cursor_left         ; tail-call
nobs:
        rts
.endproc
.export _console_write_char := console_write_char
