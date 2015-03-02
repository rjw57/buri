.include "ascii.inc"

.export putnewline

.import putc

; putnewline - write LF/CR to output
.proc putnewline
	pha			; save state
	lda #ASCII_LF		; write LF/CR
	jsr putc
	lda #ASCII_CR
	jsr putc
	pla			; restore state
	rts			; return to caller
.endproc
