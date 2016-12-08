; IRQ vector for processor.
.include "macros.inc"

.bss

irq_first_handler:    .res 2
.export irq_first_handler

.code

; =========================================================================
; irq_init: called in RESET to prepare IRQ handler chain
; =========================================================================
.export irq_init
.proc irq_init
        m16                             ; irq_handler = tail of handler
        lda #irq_handler_tail
        sta irq_first_handler
        m8
        rts
.endproc

; =========================================================================
; Tail of IRQ handlers, simply returns from interrupt
; =========================================================================
.export irq_handler_tail
.proc irq_handler_tail
        mx16
        ply
        plx
        pla
        pld
        plb

        ; The processor status register will be pulled which takes care of
        ; restoring the M and X flags.

        rti
.endproc

; =========================================================================
; vector_irq: native mode interrupt request handler
; =========================================================================
.export vector_irq
.proc vector_irq
        ; TODO: PBR, DBR and SL?

        cld                             ; in case BCD is happening
        phb
        phd
        mx16
        pha
        phx
        phy
        mx8

        jmp (irq_first_handler)
.endproc
