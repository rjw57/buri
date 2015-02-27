.include "globals.inc"

.import putc

; puts - write C-style string to output
;
; A - low byte of string address
; X - high byte of string address
;
; Corrupts ptr1
.global puts
.proc puts
	pha			; save A and X
	phx

	sta ptr1
	stx ptr1+1

@loop:
	lda (ptr1)		; load char
	beq @exit		; if 0, exit

	jsr putc		; write char
	
	inc ptr1		; increment ptr1
	bne @loop		; loop if ptr1 low byte not zero
	inc ptr1+1		; else, increment high byte
	bra @loop		; and loop

@exit:
	plx			; restore A and X
	pla
	rts			; return to caller
.endproc
