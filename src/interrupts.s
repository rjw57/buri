;
; Interrupt handling routines
;

; Interrupt handler
.export handle_irq
.proc handle_irq
	;; Nothing here yet
	rti		; return from handler
.endproc

; NMI handler. We don't handle NMIs, so simply return.
.export handle_nmi
.proc handle_nmi
	rti		; return from handler
.endproc
