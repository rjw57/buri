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
.import putln
.import readln

.import splitcli
.import findcmd

.import initscr
.import cls

; This function is never returned from.
.export init
.proc init
	jsr initio		; reset I/O device
	jsr initscr		; reset terminal

	jsr cls			; clear screen
	ldax_abs banner_str	; write banner
	jsr putln

@prompt_loop:
	lda #'*'		; write command prompt
	jsr putc

	; Read a line of input into line_buffer
	lda #<line_buffer
	sta ptr1
	lda #>line_buffer
	sta ptr1+1
	lda #>line_buffer
	lda #LINE_BUFFER_SIZE
	jsr readln

	lda line_buffer		; line zero-length? (i.e. first byte is nul)
	beq @prompt_loop	; yes, loop back to prompt

	jsr splitcli		; split line

	jsr findcmd		; find command
	cmp #0			; found?
	bne @found_command	; yes
@no_command:
	ldax_abs nsc_str	; no, print error
	jsr putln
	bra @prompt_loop	; branch
@found_command:
	jsr run_command		; run it


@no_input:
	bra @prompt_loop	; loop

; Sit in a tight loop for the rest of time.
@halt_loop:
	bra @halt_loop
.endproc

; INTERNAL proc. Simply jump to address stored in ptr1. Need to make it a
; subroutine so that one can use JSR.
.proc run_command
	jmp (ptr1)		; jump to command entry point (which will rts)
.endproc

.segment "RODATA"
banner_str:
	cstring "Buri microcomputer"
nsc_str:
	cstring "No such command"
