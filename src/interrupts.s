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

;; Poll ACIA1. Copy any incoming data into the serial device ring-buffer. If
;; the ring-buffer fills up, we should do some form of signalling but, for the
;; moment, just drop them.
@acia1:
	lda	#ACIA_ST_RDRF		; RDRF mask
	bit	ACIA1_STATUS		; look at RDRF bit
	beq	@acia1_end		; do nothing more if no data to read
	ldy	ACIA1_DATA		; load input data byte into Y come what may
@acia1_recv_data_full:
	lda	#SRL_BUF_SZ		; load max. length of input buffer
	cmp	srl_buf_len		; compare to current length
	beq	@acia1_overflow		; if equal, no room left
@acia1_add_recv_data_to_buffer:
	;; Compute insertion point
	lda	srl_buf_start		; current start of buffer
	tax				; copy this to X register

	clc
	adc	srl_buf_len		; add length of buffer
	and	#SRL_BUF_MASK		; wrap at buffer end
	tax				; set X = new insertion point
	tya				; copy stashed input data byte
	sta	srl_buffer, X		; store input byte in memory

	ldx	srl_buf_len		; load length of buffer
	inx				; increment X register
	stx	srl_buf_len		; copy back to memory
@acia1_overflow:
	;; TODO: do something other than silently dropping input
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
