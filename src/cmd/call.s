.include "macros.inc"

.importzp ptr1, ptr2
.importzp arg1
.import line_buffer
.import parsehex16
.import bad_arg_err_

; record command in command table
registercmd "call", call

; call <addr>
;
; Pushes return pointer onto stack and jumps to <addr>. <addr> should be in hex.
;
; on entry:
; 	arg{1,2,3} - offsets into line_buffer of arguments 1, 2 and 3
.proc call
	pha
	save_xy
	save_word ptr1
	save_word ptr2

	ldw ptr1, line_buffer		; *ptr1 = first argument
	lda arg1
	add_word ptr1

	ldx #1				; record this is arg1 in X
	jsr parsehex16			; parse ptr1 -> ptr2
	bcc args_parsed
	jsr bad_arg_err_
	bra exit

args_parsed:
	; ptr2 - location
	pha
	save_xy
	php				; save processor state
	jsr call_impl_
	clc
	xce				; in case called code set emulation mode
	plp				; restore processor state
	restore_xy
	pla

exit:
	restore_word ptr2
	restore_word ptr1
	restore_xy
	pla
	rts
.endproc

; INTERNAL proc. Necessary since only JMP can use indirect addressing.
.proc call_impl_
	jmp (ptr2)			; jump to address at ptr2
.endproc
