;
; Processor reset entry point
;
.include "globals.inc"

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
	lda 	#$00			; value to fill ZP with
	ldx 	#$00			; where to start writing
@loop:
	sta	$00,X			; write A to ZP location X
	inx				; increment X (wraps at $FF)
	bne	@loop			; if X has not wrapped, loop

	; Ready to start waiting on interrupts: enable them
	cli

@spin:	jmp 	@spin			; loop forever
.endproc
