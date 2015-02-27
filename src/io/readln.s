.include "ascii.inc"
.include "globals.inc"
.include "macros.inc"

.import getc
.import putc

; readln - read a line of text from the keyboard
;
; IMPORTANT: no terminating NUL character is appended to the buffer
;
; on exit:
; 	line_buffer - keyboard input
; 	line_len - number of bytes in line_buffer
.global readln
.proc readln
	push_ax			; save A, X

	stz line_len		; reset line buffer length

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

	ldx line_len		; get current line length
	cpx #LINE_BUFFER_SIZE
	beq @bell		; BELL if we're full

	sta line_buffer, X	; write character to buffer
	inx			; store new line length
	stx line_len

	bra @putc_and_loop	; echo input and loop

@got_del:
	; Input was delete or backspace. If the input buffer is non-empty,
	; remove the last character and loop.
	ldx line_len		; read current line length
	beq @bell		; if zero, send bell
	dex			; decrement
	stx line_len		; write new length

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
	pop_ax			; restore A, X
	rts			; return to caller
.endproc
