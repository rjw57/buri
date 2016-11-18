; Device driver for SPI keyboard peripheral
;
; See HARDWARE.md for more information
.include "macros.inc"

.import irq_first_handler

.import VIA_IFR, VIA_IER, VIA_PCR
.import spi_init, spi_begin, spi_exchange, spi_end

INTERRUPT_MASK = $02 ; CA1 active edge

KEYBOARD_SPI_BEGIN = $60       ; MODE 1, MSB first, dev 0
KEYBOARD_BUF_LEN = 6

.segment "OSZP" : zeropage

; =========================================================================
; Number of bytes currently in keyboard buffer
keyboard_buf_count: .res 1

.bss

; =========================================================================
; Next IRQ handler routine to pass control to after keyboard_irq_handler is
; finished.
next_handler: .res 2

; =========================================================================
; Buffer holding bytes received from keyboard
keyboard_buf: .res KEYBOARD_BUF_LEN

.code

; =========================================================================
; keyboard_irq_handler: handle keyboard interrupts if present
; =========================================================================
.export keyboard_irq_handler
.proc keyboard_irq_handler
@test:
        lda #INTERRUPT_MASK             ; is interrupt due to keyboard?
        bit VIA_IFR
        beq @next                       ; no, jump to next handler

        lda #KEYBOARD_SPI_BEGIN
        jsr spi_begin
        lda #0
        jsr spi_exchange                ; Read buffer
        jsr spi_exchange                ; get scan code
        pha
        jsr spi_end
        pla

        ldx keyboard_buf_count          ; keyboard buf full?
        cpx #KEYBOARD_BUF_LEN
        bge @test                       ; yes? re-test interrupt

        sta keyboard_buf, X             ; write byte into buffer
        inx
        stx keyboard_buf_count          ; update count
        bra @test                       ; check for more data
@next:
        jmp (next_handler)
.endproc

; =========================================================================
; keyboard_get_next_scancode: read incoming scan code byte from keyboard
;
; Sets A to scancode and X to 0 if there is a scancode present to read. Sets A
; and X to $FF if there's no byte
;
; C: i16 keyboard_get_next_scancode(void)
; =========================================================================
.export keyboard_get_next_scancode
.proc keyboard_get_next_scancode
        lda keyboard_buf_count          ; keyboard buffer empty?
        bne @buf_non_empty              ; no, pop value
        lda #$FF                        ; yes, return no code
        tax
        rts
@buf_non_empty:

        lda keyboard_buf                ; store next byte on stack
        pha

        ; We disable interrupts here as a crude form of locking to ensure that
        ; the keyboard IRQ handler does not modify the keyboard buffer while
        ; we're examinging/modifying it. We didn't need it in the common case of
        ; checking the buffer count above because we can bask in ur nice safe
        ; single-CPU world where memory reads are atomic.

        sei                             ; disable interrupts

        mx16
        lda #KEYBOARD_BUF_LEN-2
        ldx #keyboard_buf+1
        ldy #keyboard_buf
        mvn $00, $00
        mx8

        lda keyboard_buf_count          ; decrement buffer count
        dec
        sta keyboard_buf_count

        cli                             ; re-enable interrupt

        pla                             ; set return value
        ldx #$00

        rts
.endproc
.export _keyboard_get_next_scancode := keyboard_get_next_scancode

; =========================================================================
; keyboard_init: initialise the keyboard hardware
;
; C: void keyboard_init(void)
; =========================================================================
.export keyboard_init
.proc keyboard_init
        jsr spi_init                    ; initialise SPI subsystem

        stz keyboard_buf_count          ; no bytes in keyboard buffer

        lda #$01                        ; CA1 active edge is +ve
        tsb VIA_PCR

        lda #INTERRUPT_MASK             ; enable VIA interrupt
        tsb VIA_IER

        ; Install keyboar interrupt handler
        irq_add_handler keyboard_irq_handler, next_handler

        lda #KEYBOARD_SPI_BEGIN         ; reset the keyboard controller
        jsr spi_begin
        lda #$80
        jsr spi_exchange                ; reset
        jsr spi_end

        rts
.endproc
.export _keyboard_init := keyboard_init
