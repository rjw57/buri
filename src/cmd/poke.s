.include "macros.inc"

.importzp ptr1, ptr2
.importzp arg1, arg2
.import line_buffer
.import parsehex8
.import parsehex16
.import putc
.import putln
.import bad_arg_err_

; record command in command table
registercmd "poke", poke

; poke <addr> <val>
;
; Writes byte <val> at address <addr>. Both <addr> and <val> should be hex.
;
; on entry:
; 	arg{1,2,3} - offsets into line_buffer of arguments 1, 2 and 3
.proc poke
	pha
	save_xy
	save_word ptr1
	save_word ptr2

	ldw ptr1, line_buffer		; *ptr1 = first argument
	lda arg1
	add_word ptr1

	ldx #1				; record this is arg1 in X
	jsr parsehex16			; parse ptr1 -> ptr2
	bcs bad_arg

	ldw ptr1, line_buffer		; *ptr1 = second argument
	lda arg2
	add_word ptr1

	ldx #2				; record this is arg2 in X
	jsr parsehex8			; parse ptr1 -> A
	bcs bad_arg

	bra args_parsed

bad_arg:
	jsr bad_arg_err_
	bra exit

args_parsed:
	; A - value, ptr2 - location
	sta (ptr2)			; poke value
exit:
	restore_word ptr2
	restore_word ptr1
	restore_xy
	pla
	rts
.endproc
