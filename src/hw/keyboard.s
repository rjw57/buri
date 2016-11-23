; Device driver for SPI keyboard peripheral
;
; See HARDWARE.md for more information
.include "macros.inc"
.include "ring_buf.inc"

.import irq_first_handler

.import VIA_IFR, VIA_IER, VIA_PCR, VIA_ORA
.import spi_init, spi_begin, spi_exchange, spi_end

INTERRUPT_MASK = $01 ; CA2 active edge

KEYBOARD_SPI_BEGIN = $60       ; MODE 1, MSB first, dev 0

.bss

; =========================================================================
; Next IRQ handler routine to pass control to after keyboard_irq_handler is
; finished.
next_irq_handler: .res 2

; =========================================================================
; Next idle handler routine to pass control to after keyboard_idle_handler is
; finished.
next_idle_handler: .res 2

; =========================================================================
; flag set in IRQ handler to note that we need to talk to the keyboard
keyboard_wants_chat: .res 1

; =========================================================================
; Buffer holding bytes received from keyboard
KEYBOARD_RB_LEN = 4
ring_buf_reserve keyboard_ring_buf, KEYBOARD_RB_LEN

.code

; =========================================================================
; keyboard_irq_handler: handle keyboard interrupts if present
;
; IRQ handlers need to be fast. This simply sets a flag if an interrupt is due
; to the keyboard and lets the bottom end of the IRQ handler deal with it
; =========================================================================
.export keyboard_irq_handler
.proc keyboard_irq_handler
        lda #INTERRUPT_MASK             ; is interrupt due to keyboard?
        bit VIA_IFR
        bze done                        ; no, jump to next handler

        inc keyboard_wants_chat         ; increment chat flag

        lda #INTERRUPT_MASK             ; clear interrupt flag
        sta VIA_IFR                     ; this is why CA2 needs to be
                                        ; independent we don't want the later
                                        ; SPI exchange to clear the interrupt
done:
        jmp (next_irq_handler)
.endproc

; =========================================================================
; keyboard_idle_handler: bottom end of irq handler
;
; We comunicate with the keyboard outside of the IRQ handler because in the
; grand scheme of things the spi_exchange calls are quite slow and the IRQ
; handler should be as fast as possible.
; =========================================================================
.export keyboard_idle_handler
.proc keyboard_idle_handler
        lda keyboard_wants_chat         ; do we need to run the handler?
        bze done
        dec keyboard_wants_chat         ; reset chat flag

        lda #KEYBOARD_SPI_BEGIN
        jsr spi_begin
        lda #0
        jsr spi_exchange                ; Read buffer
        jsr spi_exchange                ; get scan code
        pha
        jsr spi_end
        pla

        ; push into ring buffer if non-zero
        ring_buf_push keyboard_ring_buf, KEYBOARD_RB_LEN
done:
        jmp (next_idle_handler)
.endproc

; =========================================================================
; keyboard_read_next_scancode: read incoming scan code byte from keyboard
;
; Sets A to scancode and X to 0 if there is a scancode present to read. Sets A
; and X to $FF if there's no byte
;
; C: i16 keyboard_read_next_scancode(void)
; =========================================================================
.export keyboard_read_next_scancode
.proc keyboard_read_next_scancode
        ring_buf_pop keyboard_ring_buf, KEYBOARD_RB_LEN
        bcs buf_empty
        ldx #$00
        rts
buf_empty:
        lda #$FF
        ldx #$FF
        rts
.endproc
.export _keyboard_read_next_scancode := keyboard_read_next_scancode

; =========================================================================
; keyboard_init: initialise the keyboard hardware
;
; C: void keyboard_init(void)
; =========================================================================
.export keyboard_init
.proc keyboard_init
        jsr spi_init                    ; initialise SPI subsystem

        ; initialise ring buffer
        ring_buf_init keyboard_ring_buf, KEYBOARD_RB_LEN

        stz keyboard_wants_chat         ; reset IRQ set flag

        ; Install keyboard interrupt & idle handler
        irq_add_handler keyboard_irq_handler, next_irq_handler
        idle_add_handler keyboard_idle_handler, next_idle_handler

        lda #%00000110                  ; CA2 active edge is +ve
        tsb VIA_PCR                     ; and CA2 is independent interrupt

        lda #INTERRUPT_MASK             ; enable VIA interrupt
        and #$80
        sta VIA_IER

        lda #KEYBOARD_SPI_BEGIN         ; reset the keyboard controller
        jsr spi_begin
        lda #$80
        jsr spi_exchange                ; reset
        jsr spi_end

        rts
.endproc
.export _keyboard_init := keyboard_init
