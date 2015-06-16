.include "hardware.inc"
.include "globals.inc"

.export srl_putc

; srl_putc - send a character along the serial connection
;
; on entry:
; 	A - the ASCII code of the character to send
; on exit:
; 	A - preserved
.proc srl_putc
	pha				; save A on stack
	
	lda	#ACIA_ST_TDRE		; load TDRE mask into A
wait_tx_free:
	bit	acia_sr			; is the tx register empty?
	beq	wait_tx_free		; ... no, loop

	pla				; retrieve input from stack
	sta	ACIA1_DATA		; write character to tx data reg
	pha

	lda	ACIA1_STATUS		; cache status reg after reading
	sta	acia_sr
	pla

	rts				; return
.endproc
