.include "hardware.inc"
.include "globals.inc"

.export srl_getc

; srl_getc - wait for the next character from the serial port
;
; on exit:
; 	A - the ASCII code of the character read
.proc srl_getc
	lda	#ACIA_ST_RDRF		; load RDRF mask into A

@wait_rx_full:
	bit	acia_sr			; is the rx register full?
	beq	@wait_rx_full		; ... no, loop

	lda	ACIA1_DATA		; read character from ACIA

	pha				; cache updated status reg
	lda	ACIA1_STATUS
	sta	acia_sr
	pla

	rts				; return
.endproc
