.include "macros.inc"

.export parsehex

.importzp ptr1, ptr2

; parsehex - parse a C-style string into a 16-bit value
;
; on entry:
; 	ptr1 - pointer to input string
; on exit:
; 	ptr1 - preserved
; 	ptr2 - 16-bit value
; 	carry flag - set iff there was an error
.proc parsehex
	pha
	save_xy
	save_word ptr1

	stz ptr2			; ptr2 <- 0
	stz ptr2+1

@loop:
	lda (ptr1)			; load byte @ ptr1
	beq @success			; if '\0', we have got to end

	jsr parsedigit			; parse hex digit
	bcs @exit			; if there was an error, exit

	ldx ptr2+1			; high byte of current result
	cpx #$10			; check not yet written >0 to high byte
	bcs @exit

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

	bra @loop			; next iteration
@success:
	clc
@exit:
	restore_word ptr1
	restore_xy
	pla
	rts
.endproc

; INTERNAL proc - set A to value of hex digit @ ptr1. If an error, set carry
; flag.
.proc parsedigit
	lda (ptr1)			; A = ASCII char @ ptr2

	cmp #'0'			; compare to '0'
	bcc @error			; less than, error
	cmp #'9'+1			; compare to '9'+1
	bcc @decimal			; less than, it's a decimal digit
	cmp #'A'			; compare to 'A'
	bcc @error			; less than, error
	cmp #'F'+1			; compare to 'F'+1
	bcc @upper			; less than, it's an uppercase letter
	cmp #'a'			; compare to 'a'
	bcc @error			; less than, error
	cmp #'f'+1			; compare to 'f'+1
	bcc @lower			; less than, it's an lowercase letter
@error:
	sec
	bra @exit
@decimal:
	sub #'0'			; subtract ASCII '0'
	bra @success
@upper:
	sub #'A'-$A			; subtract ASCII 'A'
	bra @success
@lower:
	sub #'a'-$A			; subtract ASCII 'a'
@success:
	clc
@exit:
	rts
.endproc
