.include "macros.inc"
.include "strings.inc"

.importzp ptr1, ptr2
.importzp arg1, arg2
.import line_buffer
.import parsehex16
.import putc
.import puthex
.import putln
.import putnewline

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
	bcs bad_arg
	bra args_parsed

bad_arg:
	txa				; char denoting arg
	add #'0'
	jsr putc
	lda #':'
	jsr putc
	ldw ptr1, bad_arg_str
	jsr putln
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
