; SPI interface
;
; Buri exposes a SPI interface to peripherals via the 6522 VIA:
;
;           |     |
;       PA0 |-->--| CLK
; VIA   PA1 |-->--| MOSI   SPI peripheral
;       PA7 |--<--| MISO
;           |     |
;
; Lines PA2, PA3 and PA4 are connected to a 74138 3-to-8 decoder to provide the
; chip select lines for the peripherals. Consequently there can be up to 8 SPI
; peripherals attached.
;
; The CA1 line is used as a peripheral interrupt. A rising edge on the CA1 line
; causes an interrupt on the processor.
.include "macros.inc"

.import VIA_ORB, VIA_IFR, VIA_IER

INTERRUPT_MASK = $02 ; CA1 active edge

.bss

; =========================================================================
; Next IRQ handler routine to pass control to after spi_irq_handler is finished.
next_handler: .res 2

.code

; =========================================================================
; spi_init: initialise SPI hardware
;
; C: void spi_init(void)
; =========================================================================
.export spi_init
.proc spi_init
        irq_add_handler spi_irq_handler, next_handler

        lda #INTERRUPT_MASK             ; enable VIA interrupt
        tsb VIA_IER
        rts
.endproc
.export _spi_init := spi_init

; =========================================================================
; spi_exchange: exchange bytes over the SPI bus
;       A - byte to send
; On exit, A is the byte received.
;
; C: u8 spi_exchange(u8 val)
; =========================================================================
.export spi_exchange
.proc spi_exchange
        rts
.endproc
.export _spi_exchange := spi_exchange

; =========================================================================
; spi_begin: begin communication with SPI peripheral
;       A - byte which specifies the mode and peripheral number
;           the two most significant bits are the SPI mode (0-3) and the
;           three least significan bits are the peripheral number
;
; At a hardware level, this sets the clockline to the idle state and takes the
; appropriate slave select line low.
;
; C: void spi_begin(u8 mode_and_device)
; =========================================================================
.export spi_begin
.proc spi_begin
        rts
.endproc
.export _spi_begin := spi_begin

; =========================================================================
; spi_end: finish communication
;
; Takes all slave select lines high and effectively terminates communication
; initiated by spi_begin.
;
; C: void spi_end(void)
; =========================================================================
.export spi_end
.proc spi_end
        rts
.endproc
.export _spi_end := spi_end

; =========================================================================
; spi_irq_handler: handle spi interrupts if present
; =========================================================================
.proc spi_irq_handler
@test:
        lda #INTERRUPT_MASK             ; is interrupt due to spi?
        bit VIA_IFR
        beq @next                       ; no, jump to next handler

        ; TODO: handle interrupt
@next:
        jmp (next_handler)
.endproc
