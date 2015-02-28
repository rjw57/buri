.include "macros.inc"

.export streq

.importzp ptr1, ptr2

; streq - compare two C-style strings for equality
;
; on entry:
; 	ptr1 - pointer to string 1
; 	ptr2 - pointer to string 2
;
; on exit:
; 	A - zero if strings differ, non-zero otherwise
; 	ptr1, ptr2 - preserved
.proc streq
	; save X
	phx
	; save ptr1, ptr2
	ldx ptr1
	phx
	ldx ptr1+1
	phx
	ldx ptr2
	phx
	ldx ptr2+1
	phx

@cmp_loop:
	lda (ptr1)			; byte from A
	eor (ptr2)			; EOR-ed with B
	bne @fail			; bytes differ

	lda #0
	cmp (ptr1)			; was byte '\0'?
	beq @success			; success

	clc
	lda #1
	adc_word ptr1			; increment ptr1

	clc
	lda #1
	adc_word ptr2			; increment ptr2

	bra @cmp_loop
@success:
	lda #1				; otherwise, match
	bra @exit
@fail:
	lda #0				; strings differ
@exit:
	; restore ptr1. ptr2
	plx
	stx ptr2+1
	plx
	stx ptr2
	plx
	stx ptr1+1
	plx
	stx ptr1

	plx
	rts				; return
.endproc
