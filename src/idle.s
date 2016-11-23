; Idle handlers

.include "macros.inc"

.bss

idle_first_handler:    .res 2
.export idle_first_handler

.code

; =========================================================================
; idle_init: called on RESET to prepare idle handler chain
; =========================================================================
.export idle_init
.proc idle_init
        m16                             ; idle_handler = tail of handler
        lda #idle_handler_tail
        sta idle_first_handler
        m8
        rts
.endproc

; =========================================================================
; idle: call idle handler chain
;
; C: void idle(void)
; =========================================================================
.export idle
.proc idle
        jmp (idle_first_handler)
.endproc
.export _idle := idle

; =========================================================================
; Tail of idle handlers, simply returns from subroutine
; =========================================================================
.export idle_handler_tail
.proc idle_handler_tail
        rts
.endproc
