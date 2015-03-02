.include "macros.inc"

.importzp ptr1
.importzp arg1, arg2, arg3

.import putln
.import putc
.import line_buffer

; echo [<arg>...]
;
; Echo arguments one per line.
;
; on entry:
; 	arg{1,2,3} - offsets into line_buffer of arguments 1, 2 and 3
;
.proc entry
	pha
	save_word ptr1

	lda arg1
	ldx #'1'
	jsr show_arg

	lda arg2
	ldx #'2'
	jsr show_arg

	lda arg3
	ldx #'3'
	jsr show_arg

	restore_word ptr1
	pla
	rts
.endproc

; INTERNAL proc - write arg value.
;
; on entry:
; 	A - offset of arg in line_buffer
; 	X - argument number in ASCII (1, 2 or 3)
.proc show_arg
	pha
	txa
	jsr putc
	lda #':'
	jsr putc
	ldw ptr1, line_buffer
	pla
	add_word ptr1
	jsr putln
	rts
.endproc

; record command in command table
registercmd "echo", entry
