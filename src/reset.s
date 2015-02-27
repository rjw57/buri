;
; Processor reset vector
;
.import init

; Called on processor reset. Bootstraps stack pointer, clears zero page and
; jumps to init.
.export reset
.proc reset
	; Bootstrap processor
	sei				; disable interrupts
	cld				; use binary mode arithmetic
	ldx	#$FF			; initialise stack pointer
	txs

	; Clear zero page
	lda 	#$00			; value to fill ZP with
	ldx 	#$00			; where to start writing
@loop:
	sta	$00,X			; write A to ZP location X
	inx				; increment X (wraps at $FF)
	bne	@loop			; if X has not wrapped, loop

	cli				; re-enable interrupts
	jmp	init			; jump to entry point
.endproc
