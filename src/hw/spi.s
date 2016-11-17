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
; chip select lines for the peripherals. Consequently there can be up to 7 SPI
; peripherals attached with SPI device "0" being no device selected.
;
; The CA1 line is used as a peripheral interrupt. A rising edge on the CA1 line
; causes an interrupt on the processor.
.include "macros.inc"

.import VIA_IFR, VIA_IER, VIA_DDRA, VIA_ORA

INTERRUPT_MASK = $02 ; CA1 active edge

; Bits corresponding to particular lines
CLK_MASK = $01
MOSI_MASK = $02
MISO_MASK = $80

; Device select bit mask
SELECT_MASK = $1C

; Bits to set/reset in DDR
DDR_SET_MASK = CLK_MASK | MOSI_MASK | SELECT_MASK
DDR_RESET_MASK = MISO_MASK

.bss

; =========================================================================
; Next IRQ handler routine to pass control to after spi_irq_handler is finished.
next_handler: .res 2

; =========================================================================
; current mode, bit order and device (argument to spi_begin)
spi_begin_arg: .res 1

.code

; =========================================================================
; spi_init: initialise SPI hardware
;
; C: void spi_init(void)
; =========================================================================
.export spi_init
.proc spi_init
        irq_add_handler spi_irq_handler, next_handler

        lda #DDR_SET_MASK
        trb VIA_ORA
        tsb VIA_DDRA

        lda #DDR_RESET_MASK
        trb VIA_DDRA

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
        ldx #8
send_loop:
        phx
        lda #1
        jsr spi_exchange_bit
        plx
        dex
        bne send_loop

        rts
.endproc
.export _spi_exchange := spi_exchange

; =========================================================================
; spi_exchange_bit: exchange single bit on SPI bus
;       A - low bit to send
;
; On exit A is 0 if a bit 0 is received and 1 if a bit 1 is received
; =========================================================================
.proc spi_exchange_bit
        tax                             ; X <- bit to send
        ldy #0                          ; Y <- received bit

        lda #$40                        ; test CPHA
        bit spi_begin_arg
        bne @cpha1
@cpha0:                                 ; CPHA = 0 - receive
        lda #MISO_MASK
        bit VIA_ORA
        beq @cpha_end
        ldy #1
        bra @cpha_end
@cpha1:                                 ; CPHA = 1 - send
        cpx #1
        bne @send0
        lda #MOSI_MASK
        tsb VIA_ORA
        bra @cpha_end
@send0:
        lda #MOSI_MASK
        trb VIA_ORA
@cpha_end:

idle_to_active_edge:
        lda #$01                        ; clock idle -> active
        eor VIA_ORA
        sta VIA_ORA

        lda #$40                        ; test CPHA
        bit spi_begin_arg
        beq @cpha0
@cpha1:                                 ; CPHA = 1 - receive
        lda #MISO_MASK
        bit VIA_ORA
        beq @cpha_end
        ldy #1
        bra @cpha_end
@cpha0:                                 ; CPHA = 0 - send
        cpx #1
        bne @send0
        lda #MOSI_MASK
        tsb VIA_ORA
        bra @cpha_end
@send0:
        lda #MOSI_MASK
        trb VIA_ORA
@cpha_end:

active_to_idle_edge:
        lda #$01                        ; clock active -> idle
        eor VIA_ORA
        sta VIA_ORA

        rts
.endproc

; =========================================================================
; spi_begin: begin communication with SPI peripheral
;       A - byte which specifies the mode and peripheral number
;
; The byte specifies SPI MODE, endianness and device number. Bit 7 is MSB, bit 0
; is LSB.
;
; |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0   |
; |  CPOL |  CPHA |  END  | --X-- | --X-- | --------DEVICE------- |
;
; The SPI mode is according to the following table:
;
; | CPOL | CPHA | Desc
; |    0 |    0 | Clock idle 0, data captured on rising edge, output on falling
; |    0 |    1 | Clock idle 0, data captured on falling edge, output on rising
; |    1 |    1 | Clock idle 1, data captured on falling edge, output on rising
; |    1 |    0 | Clock idle 1, data captured on rising edge, output on falling
;
; The END bit determines transmission order. END = 0 implies LSB first, END = 0
; implies MSB first.
;
; At a hardware level, this sets the CLK line to the idle state and takes the
; appropriate slave select line low.
;
; C: void spi_begin(u8 mode_and_device)
; =========================================================================
.export spi_begin
.proc spi_begin
        sta spi_begin_arg               ; save argument

        bit #$80                        ; test CPOL bit of mode
        beq cpol_0
cpol_1:                                 ; set clock to idle state
        lda #CLK_MASK
        tsb VIA_ORA
        bra cpol_set
cpol_0:
        lda #CLK_MASK
        trb VIA_ORA
cpol_set:

        lda #SELECT_MASK                ; ensure slave select is zero
        trb VIA_ORA
        lda spi_begin_arg               ; load argument
        asl                             ; <<= 2 so LSB corresponds to PB2
        asl
        and #SELECT_MASK                ; mask off non slave select bits
        tsb VIA_ORA                     ; set slave select bits

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
        lda #SELECT_MASK                ; ensure slave select is zero
        trb VIA_ORA

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
