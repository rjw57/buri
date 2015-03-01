.include "macros.inc"

.export parsehex16

.importzp ptr1, ptr2
.import parsehexnibble

; parsehex16 - parse a C-style string into a 16-bit value
;
; on entry:
; 	ptr1 - pointer to input string
; on exit:
; 	ptr1 - preserved
; 	ptr2 - 16-bit value
; 	carry flag - set iff there was an error
.proc parsehex16
	pha
	save_xy
	save_word ptr1

	stz ptr2			; ptr2 <- 0
	stz ptr2+1

loop:
	lda (ptr1)			; load byte  ptr1
	beq success			; if '\0', we have got to end

	lda (ptr1)			; A = ASCII char atatatat ptr2
	jsr parsehexnibble		; parse hex digit
	bcs exit			; if there was an error, exit

	ldx ptr2+1			; high byte of current result
	cpx #$10			; check not yet written >0 to high byte
	bcs exit

	asl ptr2			; shift ptr2 low nibble to high
	rol ptr2+1
	asl ptr2
	rol ptr2+1
	asl ptr2
	rol ptr2+1
	asl ptr2
	rol ptr2+1
	ora ptr2			; A = ptr2 | A
	sta ptr2			; write A back to ptr 2

	lda #1				; increment ptr1
	clc
	adc_word ptr1

	bra loop			; next iteration
success:
	clc
exit:
	restore_word ptr1
	restore_xy
	pla
	rts
.endproc
