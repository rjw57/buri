;
; Interrupt handling routines
;

; Interrupt handler
.global handle_irq
.proc handle_irq
	rti			; return from handler
.endproc

; NMI handler
.global handle_nmi
.proc handle_nmi
	rti			; return from handler
.endproc
