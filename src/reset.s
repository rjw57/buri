;
; Processor reset vector
;

.include "globals.inc"
.include "macros.inc"

.import init
.import interrupts_init

; Called on processor reset. Bootstraps stack pointer, clears zero page and
; jumps to init.
.export vector_reset
.proc vector_reset
	; Bootstrap processor
	sei				; disable interrupts
	cld				; use binary mode arithmetic
	ldx	#$FF			; initialise stack pointer
	txs

	; Switch to native mode
	clc				; clear carry bit
	xce				; exchange carry and emulation

	; ... now in 65816 native mode

	; Clear zero page
	lda 	#$00			; value to fill ZP with
	ldx 	#$00			; where to start writing
@loop:
	sta	$00,X			; write A to ZP location X
	inx				; increment X (wraps at $FF)
	bne	@loop			; if X has not wrapped, loop

	; Initialise interrupt trampolines
	jsr interrupts_init

	cli				; re-enable interrupts
	jmp	init			; jump to entry point
.endproc
