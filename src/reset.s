; Processor reset vector

.include "globals.inc"
.include "macros.inc"

.import init
.import interrupts_init

.importzp sp
.import __OSCSTACK_START__, __OSCSTACK_SIZE__

; Called on processor reset. Bootstraps stack pointer, clears direct page, sets
; native mode, ensures accumulator and index registers are 16-bit and jumps to
; init.
.export vector_reset
.proc vector_reset
	; Bootstrap processor
	sei				; disable interrupts
	cld				; use binary mode arithmetic
	ldx	#$FF			; initialise stack pointer
	txs

	; Switch to native mode & 16-bit accum/index
	set_native
	mx8

	; Clear direct page. Done with index in 8-bit mode but accumulator in
	; 16-bit so that we can write two bytes at once.
	m16
	ldx 	#$00			; where to start writing
@loop:
	stz	$00,X			; write 0000 to DP location X
	inx				; increment X (wraps at $FF)
	inx				; increment X (wraps at $FF)
	bne	@loop			; if X has not wrapped, loop

	; Initialise C stack pointer using 16-bit accumulator
	lda	#__OSCSTACK_START__ + __OSCSTACK_SIZE__
	sta	sp

	; Back to 8-bit accumulator
	m8

	jsr	interrupts_init		; initialise interrupt trampolines

	cli				; re-enable interrupts
	jmp	init			; jump to entry point
.endproc
