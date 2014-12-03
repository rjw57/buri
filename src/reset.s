;
; Processor reset entry point
;
.include "globals.inc"
.include "io.inc"

; from repl.s
.global repl

.segment "RODATA"
banner1: PString "BURI microcomputer"
banner2: PString "(C) 2014 Rich Wareham <rich.buri@richwareham.com>"

.segment "CODE"

;; Reset vector. If the ROM has an "entry point", this is it.
.export reset
.proc reset
	; Processor bootstrap
	sei				; disable interrupts
	cld				; use binary mode arithmetic

	; Initialise stack pointer
	ldx	#$FF
	txs

	; Clear zero page
clear_zp:
	lda 	#$00			; value to fill ZP with
	ldx 	#$00			; where to start writing
@loop:
	sta	$00,X			; write A to ZP location X
	inx				; increment X (wraps at $FF)
	bne	@loop			; if X has not wrapped, loop
end_clear_zp:

	; Setup ACIA1
	lda	#%11000101		; no parity, tx IRQ
	sta	ACIA1_CMD		; write command reg
	lda	#%00011111		; 8 bits, 1 stop bit, 19200 baud
	sta	ACIA1_CTRL		; write control reg
	lda	ACIA1_STATUS		; load status reg
	sta	acia1_status_cache	; store to cache

	;; Finished HW bootstap

	cli				; enable interrupts

	; Scream to the world!
	WriteLnString banner1
	WriteLnString banner2

	; Jump into the REPL
	jmp	repl
.endproc
