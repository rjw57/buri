.include "hardware.inc"
.include "globals.inc"

; initio - initialise keyboard input and screen output
.global initio
.proc initio
	pha			; save A

	; Initialise the serial port
	lda #%00011111		; 8-bit, 1 stop, 19200 baud
	sta ACIA1_CTRL
	lda #%00001001		; No parity, enable hw, interrupts
	sta ACIA1_CMD

	; Cache status register in zero page
	lda ACIA1_STATUS
	sta acia_sr

	pla			; restore A
	rts
.endproc
