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
;
; If the vectors are patched, the patches should JMP to the original location
; after handling the interrupt. There's currently no official way to hook *after* 
; the interrupt handler.
.global interrupts_init
.proc interrupts_init
	mx16				; enable 16-bit registers
	lda #irq_tail
	sta irq_vector
	lda #nmi_tail
	sta nmi_vector
	lda #brk_tail
	sta brk_vector
	mx8			; disable 16-bit registers
	rts
.endproc

; Saves registers onto stack. Makes sure that 16-bit mode is switched on for
; A and X, Y. Pushes 9 bytes onto the stack.
.macro save_regs
	pha
	save_xy
	save_bd
.endmacro

; Undoes save_regs.
.macro restore_regs
	restore_bd
	restore_xy
	pla
.endmacro

; Configure data bank and direct page registers. Corrupts A and sets 8-bit A.
; and index
.proc setup_pages
	m16
	lda #0			; A = 0
	tcd			; A -> direct page reg.
	m8
	pha
	plb			; A -> data bank register
	rts
.endproc

; Begin an interrupt handler. Saves A, X an Y registers on stack in 16-bit mode,
; saves DB and DP registers. Resets DB and DP registers to zero.
.macro begin_handler
	mx16
	save_regs
	jsr setup_pages
.endmacro

; End an interupt handler. Undoes the actions of begin_handler and issues an RTI
; instruction to return to the previous execution location.
.macro end_handler
	mx16
	restore_regs
	rti
.endmacro

; Interrupt handler head
.global irq_head
.proc irq_head
	begin_handler
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
	end_handler
.endproc

; NMI handler
.global nmi_head
.proc nmi_head
	begin_handler
	jmp (nmi_vector)
.endproc

.global nmi_tail
.proc nmi_tail
	end_handler
.endproc

; BRK handler. Obtain byte immediately following BRK instruction and push onto
; stack. Call brk_vector trampoline with values of A, X and Y registers
; preserved.
.global brk_head
.proc brk_head
	begin_handler

	; We enable interrupts here since some OS routines (notably getc)
	; require interrupts be enabled. They also have indeterminate latency
	; so we should make sure interrupts will be handled ASAP. We're OK
	; to re-enable here since we know that we're not going to perform any
	; more BRKs until the brk_signature value has been read by brk_tail.

	cli			; Enable interrupts

	; We're going to examine the stack to find the address where the BRK
	; instruction was and read the continuing byte. This then gets stuffed
	; into the zero-page variable brk_signature.

	; The stack at this point looks like the following with the offsets
	; marked:
	; | PBR | PC Hi | PC Lo | P | A | A | X | X | Y | Y | B | D | D |
        ;   13    12      11      10  9   8   7   6   5   4   3   2   1

	; Save regs which we corrupt. This adds 1 byte to the stack
	; which needs to be corrected for below.
	phb

	lda 13 + 1, S		; Load the PBR into A
	pha			; A -> stack
	plb			; stack -> data bank reg
	mx16
	lda 11 + 1, S		; PC -> A
	tax			; X = A
	dex			; X -= 1
	sep #$20		; A -> 8.bit
	lda 0, X		; BRK following byte -> A
	mx8

	plb			; Restore data bank reg
	sta brk_signature	; Save BRK signature

	; Now we're pulled the DBR, we no longer need the correction
	mx16
	lda 8, S		; Load enty value for A
	mx8

	jmp (brk_vector)
.endproc

.global brk_tail
.proc brk_tail
	jsr handle_brk		; Dispatch call

	; Unusually, BRK can return a value in A. The simplest thing to do
	; is to directly write it into the stack
	mx16
	sta 8, S		; Write value for A
	end_handler
.endproc
