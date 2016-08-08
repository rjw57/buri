.include "hardware.inc"
.include "globals.inc"

.export haveinput

; haveinput - test if input is available for reading
;
; on exit:
; 	carry - set if input present, clear otherwise
.proc haveinput
	pha
	lda	#ACIA_ST_RDRF		; load RDRF mask into A
	bit	acia_sr			; is the rx register full?
	beq	no_input		; no, no input
	sec
	pla
	rts				; return
no_input:
	clc
	pla
	rts				; return
.endproc
