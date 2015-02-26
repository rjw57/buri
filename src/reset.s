;
; Processor reset vector
;
.import init

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

	; Jump to initial entry point
	jmp	init
.endproc
