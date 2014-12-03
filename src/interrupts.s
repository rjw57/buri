;
; Interrupt handling routines
;
.include "globals.inc"

; Interrupt handler
.global handle_irq
.proc handle_irq
	; Save A, X and Y
	pha
	txa
	pha
	tya
	pha

;; Poll ACIA1
acia1:
	bit	ACIA1_STATUS	; test IRQ bit in status reg.
	bpl	exit		; skip if clear

	; Copy status register into cache
	lda	ACIA1_STATUS
	sta	acia1_status_cache;

exit:
	; Restore A, X and Y
	pla
	tay
	pla
	tax
	pla

	rti			; return from handler
.endproc

; NMI handler. We don't handle NMIs, so simply return.
.global handle_nmi
.proc handle_nmi
	rti			; return from handler
.endproc
