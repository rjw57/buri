; Device driver for PS/2 keyboard attached to 6522 VIA.
.include "macros.inc"

.import irq_first_handler

; The Búri keyboard is attached to the 6522 VIA's port A. When a new byte is
; available, it is presented on port A and CA1 is pulsed.

VIA_BASE = $DEF0
VIA_ORA = VIA_BASE + 1
VIA_IFR = VIA_BASE + 13
VIA_IER = VIA_BASE + 14

.bss

; Next IRQ handler routine to pass control to after keyboard_irq_handler is
; finished.
next_handler: .res 2

.segment "OSZP" : zeropage

; TODO: currently we just stuff the byte from the keyboard in this ZP location.
; We should do more.
keyboard_byte: .res 1

.code

.proc keyboard_irq_handler
@test:
        lda #$02                        ; is interrupt due to keyboard?
        bit VIA_IFR
        beq @next                       ; no, jump to next handler
        lda VIA_ORA                     ; read keyboard byte from VIA
        sta keyboard_byte               ; stuff in ZP
        bra @test                       ; check for more data
@next:
        jmp (next_handler)
.endproc

.export keyboard_init
.proc keyboard_init
        irq_add_handler keyboard_irq_handler, next_handler

        lda #$02                        ; enable interrupt on CA1 active edge
        tsb VIA_IER

        rts
.endproc
.export _keyboard_init := keyboard_init
