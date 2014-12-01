;
; Interrupt handling routines
;

.export irq
.export nmi

; Interrupt handler
irq:
	rti		; return from handler

; NMI handler
nmi:
	rti		; return from handler

