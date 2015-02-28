; Initial routine for OS
;
; When this is called, zero page has been cleared and the processor has been
; bootstrapped.

.include "ascii.inc"
.include "globals.inc"
.include "hardware.inc"
.include "macros.inc"

.import initio
.import putc
.import getc
.import puts
.import readln

.import initscr
.import cls

; This function is never returned from.
.export init
.proc init
	jsr initio		; reset I/O device
	jsr initscr		; reset terminal

	jsr cls			; clear screen
	ldaxi banner_str	; write banner
	jsr puts
	lda #ASCII_CR		; write new line
	jsr putc
	lda #ASCII_LF
	jsr putc

@prompt_loop:
	lda #'*'		; write command prompt
	jsr putc

	; Read a line of input
	lda #<line_buffer
	sta ptr1
	lda #>line_buffer
	sta ptr1+1
	lda #>line_buffer
	lda #LINE_BUFFER_SIZE
	jsr readln

	lda line_buffer		; line zero-length? (i.e. first byte is nul)
	beq @prompt_loop	; yes, loop back to prompt

	ldaxi line_buffer	; no, write it back out
	jsr puts

	lda #ASCII_CR		; write LF/CF
	jsr putc
	lda #ASCII_LF
	jsr putc

@no_input:
	bra @prompt_loop	; loop

; Sit in a tight loop for the rest of time.
@halt_loop:
	bra @halt_loop
.endproc

.segment "RODATA"
banner_str:
	cstring "Buri microcomputer"
