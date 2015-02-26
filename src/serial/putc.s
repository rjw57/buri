.include "hardware.inc"

; putc - send a character along the serial connection
;
; A - the ASCII code of the character to send
.proc putc
	pha				; save A on stack
	
	lda	#ACIA_ST_TDRE		; load TDRE mask into A
@wait_tx_free:
	bit	ACIA1_STATUS		; is the tx register empty?
	beq	@wait_tx_free		; ... no, loop

	pla				; retrieve input from stack
	sta	ACIA1_DATA		; write character to tx data reg
	rts				; return
.endproc
