;
; Macros and global symbols for I/O.
;

.global srl_puts
.global srl_putc

; Write a Pascal-style string to the serial port.
; Corrupts: A and ptr1
.macro WriteString Symbol
	lda	#<(Symbol+1)
	sta	ptr1
	lda	#>(Symbol+2)
	sta	ptr1+1
	lda	Symbol
	jsr	srl_puts
.endmacro

; Write a Pascal-style string to the serial port followed by CRLF
; Corrupts: A and ptr1
.macro WriteLnString Symbol
	WriteString	Symbol
	lda		#$0D		; load CR
	jsr		srl_putc	; output
	lda		#$0A		; load LF
	jsr		srl_putc	; output
.endmacro

