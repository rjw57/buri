;
; Macros and global symbols for I/O.
;

;; Well-known I/O devices
ACIA1 		= $8800
ACIA1_DATA 	= ACIA1
ACIA1_STATUS 	= ACIA1 + 1
ACIA1_CMD 	= ACIA1 + 2
ACIA1_CTRL 	= ACIA1 + 3

;; Constants
ACIA_ST_TDRE = %00010000	; status: transmit data register empty
ACIA_ST_RDRF = %00001000	; status: read data register full

; Reset serial device
.global srl_reset

; Write single character
.global srl_puts

; Write string
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

