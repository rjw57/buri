; Console driver initialisation
.include "macros.inc"

.import vdp_init, vdp_tick

.importzp console_cursor_row, console_cursor_col
.import console_cursor_recalc, console_cursor_save, console_cursor_char
.import console_cursor_draw, console_set_cursor_char

.bss
next_handler: .res 2
.code

; =========================================================================
; console_init: initialise console driver
;
; C: void console_init(void)
; =========================================================================
.export console_init
.proc console_init
        ; Initialise global state
        stz console_cursor_save
        stz console_cursor_row
        stz console_cursor_col
        jsr console_cursor_recalc

        lda #'_'
        sta console_cursor_char
        jsr console_cursor_draw

        ; add idle handler
        idle_add_handler console_idle, next_handler

        rts
.endproc
.export _console_init := console_init

; =========================================================================
; console_idle: idle handler
;
; C: void console_idle(void)
; =========================================================================
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

        jmp (next_handler)
.endproc
