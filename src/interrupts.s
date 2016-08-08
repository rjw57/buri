;
; Interrupt handling routines
;
.include "globals.inc"
.include "hardware.inc"

; Push state onto stack
.macro push_state
	pha
	phx
	phy
	phb
	phd
.endmacro

; Pop state from stack
.macro pop_state
	pld
	plb
	ply
	plx
	pla
.endmacro

; Configure data bank and direct page registers
.proc setup_pages
	lda #0			; A = 0
	tcd			; A -> direct page reg.
	xba			; A <-> data bank reg.
	rts
.endproc

; Interrupt handler
.global vector_irq
.proc vector_irq
	push_state
	jsr setup_pages

	; ACIA1 - copy status reg if interupt bit set
	lda ACIA1_STATUS
	bpl acia_done
	sta acia_sr
acia_done:

	pop_state
	rti			; return from handler
.endproc

; NMI handler
.global vector_nmi
.proc vector_nmi
	rti			; return from handler
.endproc

; BRK handler
.global vector_brk
.proc vector_brk
	rti			; return from handler
.endproc

