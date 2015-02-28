.include "ascii.inc"

.export putln

.import putc
.import puts

; putln - write C-style string to output followed by ASCII LF/CR
;
; A - low byte of string address
; X - high byte of string address
.proc putln
	pha			; save state

	jsr puts		; write string

	lda #ASCII_LF		; write LF/CR
	jsr putc
	lda #ASCII_CR
	jsr putc

	pla			; restore state
	rts			; return to caller
.endproc
