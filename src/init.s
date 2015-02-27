; Initial routine for OS
;
; When this is called, zero page has been cleared and the processor has been
; bootstrapped.

.include "ascii.inc"
.include "globals.inc"
.include "hardware.inc"

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
	lda #<banner_str	; write banner
	ldx #>banner_str
	jsr puts
	lda #ASCII_CR		; write new line
	jsr putc
	lda #ASCII_LF
	jsr putc

@prompt_loop:
	lda #<prompt_str	; write command prompt
	ldx #>prompt_str
	jsr puts

	; Read a line of input
	jsr readln

	; Write it back out
	ldx #0
	cpx line_len
	beq @no_input
@write_loop:
	lda line_buffer, X
	jsr putc
	inx
	cpx line_len
	bne @write_loop

	lda #ASCII_CR		; write new line
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
	.byte "Buri microcomputer"
	.byte 0
prompt_str:
	.byte "* "
	.byte 0
