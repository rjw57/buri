;
; Macros and global symbols for I/O.
;

SCREEN_START	= $7B00				; start of screen page
SCREEN_COLS	= 48
SCREEN_ROWS	= 26
SCREEN_N_BYTES	= SCREEN_COLS * SCREEN_ROWS 	; size of *visible* screen
SCREEN_N_PGS	= (SCREEN_N_BYTES + $FE) >> 8	; rounded *up* size of screen in pages

;; Well-known I/O devices
ACIA1 		= $8800
ACIA1_DATA 	= ACIA1
ACIA1_STATUS 	= ACIA1 + 1
ACIA1_CMD 	= ACIA1 + 2
ACIA1_CTRL 	= ACIA1 + 3

;; Constants
ACIA_ST_TDRE = %00010000	; status: transmit data register empty
ACIA_ST_RDRF = %00001000	; status: read data register full

; Serial device
.global srl_reset
.global srl_puts
.global srl_putc
.global srl_getc

; Screen memory
.global scrn_clear
.global scrn_putc
.global scrn_puts

; Write a Pascal-style string to the screen.
; Corrupts: A and ptr1
.macro WriteString Symbol
	lda	#<(Symbol+1)
	sta	ptr1
	lda	#>(Symbol+2)
	sta	ptr1+1
	lda	Symbol
	jsr	scrn_puts
.endmacro

; Write a Pascal-style string to the screen followed by CRLF
; Corrupts: A and ptr1
.macro WriteLnString Symbol
	WriteString	Symbol
	lda		#ASCII_CR	; load CR
	jsr		scrn_putc	; output
	lda		#ASCII_NL	; load LF
	jsr		scrn_putc	; output
.endmacro

