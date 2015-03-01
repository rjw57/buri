.include "hardware.inc"

.export haveinput

; haveinput - clear carry flag if input available, set otherwise
.proc haveinput
	pha
	lda	#ACIA_ST_RDRF		; load RDRF mask into A
	bit	ACIA1_STATUS		; is the rx register full?
	beq	no_input		; no, no input
	clc
	pla
	rts				; return
no_input:
	sec
	pla
	rts				; return
.endproc
