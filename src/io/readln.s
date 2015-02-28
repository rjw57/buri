.include "ascii.inc"
.include "globals.inc"
.include "macros.inc"

.import getc
.import putc

; readln - read a line of text from the keyboard
;
; on entry:
; 	ptr1 - destination buffer
; 	A - maximum length of buffer to read including terminating null
;
; on exit:
;	ptr1 - pointer to input line with terminating null
.global readln
.proc readln
	push_axy		; save A, X, Y
	ldx tmp1		; save tmp1
	phx

	cmp #0			; is A == 0?
	beq @exit		; yes, exit immediately

	tax
	dex
	stx tmp1		; store max length-1 in tmp1

	ldy #0
@read_loop:
	jsr getc		; read input from keyboard

	cmp #ASCII_CR		; was input CR?
	beq @got_cr		; yes, return to caller
	cmp #ASCII_DEL		; delete?
	beq @got_del		; yes, handle it
	bcs @bell		; >ascii del, send a bell
	cmp #ASCII_BS		; backspace?
	beq @got_del		; yes, treat as delete
	cmp #' '		; compare to space
	bcc @bell		; less than space, bell

	cpy tmp1		; line length vs max size?
	beq @bell		; BELL if we're full

	sta (ptr1), Y		; write character to buffer
	iny			; increment line length

	bra @putc_and_loop	; echo input and loop

@got_del:
	; Input was delete or backspace. If the input buffer is non-empty,
	; remove the last character and loop.
	cpy #0			; current line length == 0?
	beq @bell		; if yes, send bell

	lda #0
	sta (ptr1), Y		; if no, write zero to current position
	dey			; decrement

	lda #ASCII_BS		; rub out character with space
	jsr putc
	lda #' '
	jsr putc

	lda #ASCII_BS		; write BS again
	bra @putc_and_loop
	
@bell:
	lda #ASCII_BEL		; write BELL to output and fall through to...

@putc_and_loop:
	jsr putc		; write code in A
	bra @read_loop		; ... and loop

@got_cr:
	lda #ASCII_LF		; write LF to output
	jsr putc
	lda #ASCII_CR		; write CR to output
	jsr putc
@exit:
	lda #0
	sta (ptr1), Y		; store null byte @ end

	plx			; restore tmp1
	stx tmp1
	pop_axy			; restore A, X, Y
	rts			; return to caller
.endproc
