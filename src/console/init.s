; Console driver initialisation
.include "macros.inc"

.import keyboard_init, vdp_init
.import console_cursor_set

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

        lda #0
        ldx #0
        jmp console_cursor_set

        rts
.endproc
.export _console_init := console_init
