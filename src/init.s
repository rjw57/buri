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

.import _putln, _initscr, _cls

; After reset sets up the direct page, initial processor registers and processor
; mode, this procedure is called. It sets up the IO devices and launches the
; CLI.
.export init
.proc init
	mx8

	jsr initio		; reset I/O device

	jsr _initscr		; reset terminal
	jsr _cls		; clear screen

	lda #<banner1_str
	ldx #>banner1_str
	jsr _putln
	lda #<banner2_str
	ldx #>banner2_str
	jsr _putln

prompt_loop:
	lda #'*'		; write command prompt
	jsr putc

	; Read a line of input into line_buffer
	lda #<line_buffer
	sta ptr1
	lda #>line_buffer
	sta ptr1+1
	lda #LINE_BUFFER_SIZE
	jsr readln

	lda line_buffer		; line zero-length? (i.e. first byte is nul)
	beq prompt_loop	; yes, loop back to prompt

	jsr splitcli		; split line

	jsr findcmd		; find command
	cmp #0			; found?
	bne found_command	; yes
no_command:
	ldw ptr1, nsc_str	; no, print error
	jsr putln
	bra prompt_loop	; branch

found_command:
	jsr run_command		; run it
	bra prompt_loop	; loop

; Sit in a tight loop for the rest of time.
halt_loop:
	bra halt_loop
.endproc

; INTERNAL proc. Jump to address stored in ptr1.
.proc run_command
	jmp (ptr1)		; jump to command entry point (which will rts)
.endproc

.segment "RODATA"
banner1_str:
	cstring "Buri microcomputer"
banner2_str:
	cstring "(C) 2015, 2016 Rich Wareham <rich.buri@richwareham.com>"
nsc_str:
	cstring "No such command"
