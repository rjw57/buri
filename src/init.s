; Initial routine for OS
;
; When this is called, zero page has been cleared and the processor has been
; bootstrapped.
;
; This function is never returned from.
.export init
.proc init

; Sit in a tight loop for the rest of time.
	clc
@halt_loop:
	bcc @halt_loop
.endproc
