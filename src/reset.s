;
; Processor reset entry point
;
.include "globals.inc"
.include "io.inc"

; from repl.s
.global repl

.segment "RODATA"
banner1: PString "BURI microcomputer system"

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

	; Clear screen with '#' character. We do this as early as possible
	; to diagnose failure to proceed in this routine.
	lda	#'#'
	jsr	scrn_clear

	; Reset serial port
	jsr	srl_reset

	; Finished HW bootstap, enable interrupts
	cli

	; Clear screen with ' ' character. Ready for screaming to the world!
	lda	#' '
	jsr	scrn_clear

	; Scream to the world!
	WriteLnString banner1

	; Jump into the REPL
	jmp	repl
.endproc
