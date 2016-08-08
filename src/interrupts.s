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

; Interrupt handler head
.global irq_head
.proc irq_head
	push_state
	jsr setup_pages
	jmp (irq_vector)
.endproc

; Interrupt handler tail
.global irq_tail
.proc irq_tail
	; ACIA1 - copy status reg if interupt bit set
	lda ACIA1_STATUS
	bpl acia_done
	sta acia_sr
acia_done:

	pop_state
	rti			; return from handler
.endproc

; NMI handler
.global nmi_head
.proc nmi_head
	push_state
	jsr setup_pages
	jmp (nmi_vector)
.endproc

.global nmi_tail
.proc nmi_tail
	pop_state
	rti			; return from handler
.endproc

; BRK handler
.global brk_head
.proc brk_head
	push_state
	jsr setup_pages
	jmp (brk_vector)
.endproc

.global brk_tail
.proc brk_tail
	pop_state
	rti			; return from handler
.endproc
