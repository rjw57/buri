; Initial routine for OS
;
; When this is called, zero page has been cleared and the processor has been
; bootstrapped.

.include "hardware.inc"

.import putc
.import getc

; This function is never returned from.
.export init
.proc init
	; Initialise the serial port
	lda %00011111		; 8-bit, 1 stop, 19200 baud
	sta ACIA1_CTRL
	lda %00001011		; No parity, enable hw, no interrupts
	sta ACIA1_CMD

	; Loop reading a character from serial port and echo it back
@echo_loop:
	jsr getc		; Read....
	jsr putc		; Write...
	bra @echo_loop		; loop

; Sit in a tight loop for the rest of time.
@halt_loop:
	bra @halt_loop
.endproc
