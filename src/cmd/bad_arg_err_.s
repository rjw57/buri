.include "macros.inc"
.include "strings.inc"

.export bad_arg_err_

.importzp ptr1
.import putc, putnewline, puts

; bad_arg_err_ - write "bad argument" error to output and set carry flag
;
; Unlike many functions, this takes its input in X. This is to allow convenient
; use around functions which return their values in A.
;
; on entry:
; 	X - 1-based argument index.
; on exit:
; 	X - preserved
; 	carry flag set
.proc bad_arg_err_
	pha
	save_xy
	save_word ptr1

	ldw ptr1, bad_arg_str
	jsr puts
	lda #' '
	jsr putc
	txa				; char denoting arg
	add #'0'
	jsr putc
	jsr putnewline

	restore_word ptr1
	restore_xy
	pla
	rts
.endproc
