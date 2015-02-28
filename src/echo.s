.include "macros.inc"

.importzp arg1
.importzp arg2
.importzp arg3

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
entry:
	pha
	save_xy

	lda #'1'
	jsr putc
	lda #':'
	jsr putc
	ldax_abs line_buffer
	add arg1		; add offset (low byte)
	jsr putln

	lda #'2'
	jsr putc
	lda #':'
	jsr putc
	ldax_abs line_buffer
	add arg2		; add offset (low byte)
	jsr putln

	lda #'3'
	jsr putc
	lda #':'
	jsr putc
	ldax_abs line_buffer
	add arg3		; add offset (low byte)
	jsr putln

	restore_xy
	pla
	rts

; record command in command table
registercmd "echo", entry
