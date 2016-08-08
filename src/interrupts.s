;
; Interrupt handling routines
;
.include "macros.inc"
.include "globals.inc"
.include "hardware.inc"

; Initialise interrupt handler trampolines. To allow for software modification
; or interrupt behaviour, the "head" of the interrupt service routine jumps to
; the bank zero addresses stored at {irq,nmi,brk}_vector. By default these
; are appropriate ROM-based interrupt handlers. By writing their own values to
; these memory locations software may "patch" the vectors.
.global interrupts_init
.proc interrupts_init
	pha
	set_16				; enable 16-bit registers
	lda #irq_tail
	sta irq_vector
	lda #nmi_tail
	sta nmi_vector
	lda #brk_tail
	sta brk_vector
	reset_16			; disable 16-bit registers
	pla
	rts
.endproc

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
