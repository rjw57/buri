;
; Interrupt handling routines
;
.include "macros.inc"
.include "globals.inc"
.include "hardware.inc"

.import handle_brk

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

; Saves registers onto stack. Makes sure that 16-bit mode is switched on for
; A and X, Y. Pushes 9 bytes onto the stack.
.macro save_regs
	set_16
	pha
	save_xy
	save_bd
	reset_16
.endmacro

; Undoes save_regs.
.macro restore_regs
	set_16
	restore_bd
	restore_xy
	pla
	reset_16
.endmacro

; Configure data bank and direct page registers
.proc setup_pages
	pha
	set_16
	lda #0			; A = 0
	tcd			; A -> direct page reg.
	reset_16
	pha
	plb			; A -> data bank register
	pla
	rts
.endproc

; Interrupt handler head
.global irq_head
.proc irq_head
	save_regs
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

	restore_regs
	rti			; return from handler
.endproc

; NMI handler
.global nmi_head
.proc nmi_head
	save_regs
	jsr setup_pages
	jmp (nmi_vector)
.endproc

.global nmi_tail
.proc nmi_tail
	restore_regs
	rti			; return from handler
.endproc

; BRK handler. Obtain byte immediately following BRK instruction and push onto
; stack. Call brk_vector trampoline with values of A, X and Y registers
; preserved.
.global brk_head
.proc brk_head
	save_regs
	jsr setup_pages

	; We're going to examine the stack to find the address where the BRK
	; instruction was and read the continuing byte. This then gets stuffed
	; into the zero-page variable brk_signature.

	; The stack at this point looks like the following with the offsets
	; marked:
	; | PBR | PC Hi | PC Lo | P | A | A | X | X | Y | Y | B | D | D |
        ;   13    12      11      10  9   8   7   6   5   4   3   2   1

	; Save regs which we corrupt. This adds 2 bytes to the stack
	; which needs to be corrected for below.
	pha
	phb

	lda 13 + 2, S		; Load the PBR into A
	pha			; A -> stack
	plb			; stack -> data bank reg
	set_16
	lda 11 + 2, S		; PC -> A
	tax			; X = A
	dex			; X -= 1
	sep #$20		; A -> 8.bit
	lda 0, X		; BRK following byte -> A
	reset_16

	plb			; Restore data bank reg
	sta brk_signature	; Save BRK signature
	pla			; Restore other regs

	jmp (brk_vector)
.endproc

.global brk_tail
.proc brk_tail
	jsr handle_brk
	restore_regs
	rti			; return from handler
.endproc
