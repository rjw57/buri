;
; Interrupt handling routines
;
.include "globals.inc"
.include "hardware.inc"

; Interrupt handler
.global handle_irq
.proc handle_irq
	pha

	; ACIA1 - copy status reg if interupt bit set
	lda ACIA1_STATUS
	bpl acia_done
	sta acia_sr
acia_done:

	pla
	rti			; return from handler
.endproc

; NMI handler
.global handle_nmi
.proc handle_nmi
	rti			; return from handler
.endproc
