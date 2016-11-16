; Console driver initialisation
.include "macros.inc"

.import keyboard_init, vdp_init

.importzp console_cursor_row, console_cursor_col
.import console_cursor_recalc

; =========================================================================
; console_init: initialise console driver
;
; calls: vdp_init, keyboard_init
;
; C: void console_init(void)
; =========================================================================
.export console_init
.proc console_init
        jsr vdp_init
        jsr keyboard_init
        stz console_cursor_row
        stz console_cursor_col
        jsr console_cursor_recalc
        rts
.endproc
.export _console_init := console_init
