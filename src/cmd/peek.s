.include "macros.inc"

.importzp ptr1, ptr2
.importzp arg1, arg2
.import line_buffer
.import parsehex16
.import puthex, putnewline
.import bad_arg_err_

; record command in command table
registercmd "peek", peek

; peek <addr>
;
; Writes hex representation of byte at <addr> to output.
;
; on entry:
; 	arg{1,2,3} - offsets into line_buffer of arguments 1, 2 and 3
.proc peek
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
	lda (ptr2)			; peek value
	jsr puthex
	jsr putnewline

exit:
	restore_word ptr2
	restore_word ptr1
	restore_xy
	pla
	rts
.endproc
