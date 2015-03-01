.include "macros.inc"

.export puts

.importzp ptr1
.import putc

; puts - write C-style string to output
;
; on entry:
; 	ptr1 - address of string
; on exit:
; 	ptr1 - preserved
.proc puts
	pha
	save_word ptr1

loop:
	lda (ptr1)		; load char
	beq exit		; if 0, exit

	jsr putc		; write char
	
	inc_word ptr1		; increment ptr1
	bra loop		; and loop

exit:
	restore_word ptr1
	pla
	rts			; return to caller
.endproc
