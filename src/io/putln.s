.include "ascii.inc"

.export putln

.import puts
.import putnewline

; putln - write C-style string to output followed by ASCII LF/CR
;
; on entry:
; 	ptr1 - address of string
; on exit:
; 	ptr1 - preserved
.proc putln
	pha			; save state

	jsr puts		; write string
	jsr putnewline		; write newline

	pla			; restore state
	rts			; return to caller
.endproc
