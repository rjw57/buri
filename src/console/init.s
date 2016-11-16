; Console driver initialisation
.include "macros.inc"

.import keyboard_init, vdp_init

.importzp console_cursor_row, console_cursor_col
.import console_cursor_recalc, console_cursor_save, console_cursor_char
.import console_cursor_draw

; =========================================================================
; console_init: initialise console driver
;
; calls: vdp_init, keyboard_init
;
; C: void console_init(void)
; =========================================================================
.export console_init
.proc console_init
        ; Initialise hardware
        jsr vdp_init
        jsr keyboard_init

        ; Initialise global state
        stz console_cursor_save
        stz console_cursor_row
        stz console_cursor_col
        jsr console_cursor_recalc

        lda #'_'
        sta console_cursor_char
        jsr console_cursor_draw

        rts
.endproc
.export _console_init := console_init
