;
; Interrupt handling routines
;
.include "globals.inc"
.include "io.inc"

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
@acia1:
	lda	ACIA1_STATUS
	sta	acia1_status_cache	; copy status register into cache

	lda	#$FF
	sta	$12

	bit	acia1_status_cache	; test IRQ bit in status register
	bpl	@acia1_end		; if unset, skip to next handler

	sta	$10
	lda	#$FF
	sta	$11
	
	; If received data reg is full, copy it
	lda	#$FF
	sta	acia1_recv_data

	lda	#(1<<3)
	bit	acia1_status_cache
	beq	@acia1_recv_data_empty
@acia1_recv_data_full:
	lda	ACIA1_DATA
	sta	acia1_recv_data
@acia1_recv_data_empty:
@acia1_end:

@exit:
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
