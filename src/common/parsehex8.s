.include "macros.inc"

.export parsehex8

.importzp ptr1, tmp1
.import parsehexnibble

; parsehex8 - parse a C-style string into a 8-bit value
;
; on entry:
; 	ptr1 - pointer to input string
; on exit:
; 	A - byte value
; 	ptr1 - preserved
; 	carry flag - set iff there was an error
.proc parsehex8
	save_xy
	save_word ptr1
	save_byte tmp1

	; NB. we build result in tmp1
	stz tmp1
loop:
	lda (ptr1)			; load byte  ptr1
	beq success			; if '\0', we have got to end

	lda (ptr1)			; A = ASCII char at ptr2
	jsr parsehexnibble		; parse hex digit
	bcs exit			; if there was an error, exit

	ldx tmp1
	cpx #$10			; check not yet written >0 to high nibble
	bcs exit

	asl tmp1			; shift low nibble to high
	asl tmp1
	asl tmp1
	asl tmp1
	ora tmp1			; A = tmp1 | A
	sta tmp1			; write A back to tmp1

	inc_word ptr1			; increment ptr1

	bra loop			; next iteration
success:
	lda tmp1			; load return value
	clc
exit:
	restore_byte tmp1
	restore_word ptr1
	restore_xy
	rts
.endproc
