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
; peripherals attached with SPI device "7" being no device selected.
;
; This implementation bit-bangs the SPI protocol. It can probably be made more
; efficient by having dedicated spi_exchange_{msb,lsb}_first subroutines and
; spi_exchange_{0,1,2,3} subroutines. This might increase code size but since
; SPI can be used inside IRQ handlers, speed is preferred.

.include "macros.inc"

.import VIA_DDRA, VIA_ORA

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
; current mode, bit order and device (argument to spi_begin)
spi_begin_arg: .res 1

.code

; =========================================================================
; spi_init: initialise SPI hardware
;
; spi_init may be called multiple times without side effect. Is should not be
; called within a spi_begin/spi_end section.
;
; C: void spi_init(void)
; =========================================================================
.export spi_init
.proc spi_init
        lda #SELECT_MASK                ; select device "7"
        tsb VIA_ORA

        lda #DDR_SET_MASK               ; set/reset bits in DDR
        tsb VIA_DDRA
        lda #DDR_RESET_MASK
        trb VIA_DDRA

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
        jmp spi_exchange_msb_first
.endproc
.export _spi_exchange := spi_exchange

; =========================================================================
; spi_exchange_bit: exchange single bit on SPI bus
;       C flag - bit to send
;
; On exit the C flag is set to the recieved bit
; =========================================================================
.proc spi_exchange_bit
        jmp spi_exchange_bit_01
.endproc

; the following are fragments used to stitch each implementation
; together

; TODO: other modes

.proc spi_exchange_msb_first
        ldy #0                          ; Y <- recv. byte
        ldx #8
send_loop:
        ; on each iteration: A - byte sending, Y - byte receiving

        rol                             ; C <- next bit
        jsr fragment_exchange_bit       ; exchange bit
        tya                             ; shift C into Y
        rol
        tay

        dex
        bne send_loop
send_done:
        tya                             ; A <- recv. byte

        rts
.endproc

; spi_exchange but preserves 8-bit regs
.proc fragment_exchange_bit
        phy
        phx
        pha
        jsr spi_exchange_bit
        pla
        plx
        ply
        rts
.endproc

.macro clk_0_to_1
        inc VIA_ORA
.endmacro

.macro clk_1_to_0
        inc VIA_ORA
.endmacro

; CPOL=0, CPHA = 1
.proc spi_exchange_bit_01
        lda #MOSI_MASK
        trb VIA_ORA
        lda #$00                        ; if carry set, A = 1
        adc #$00
        asl                             ; carry bit is now bit 1 (MOSI)
        tsb VIA_ORA
        clk_0_to_1
        sec
        bit VIA_ORA
        bmi recv1
        clc
recv1:
        clk_1_to_0
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
; The END bit determines transmission order. END = 0 implies LSB first, END = 1
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
        lda #SELECT_MASK                ; ensure slave select is device 7
        tsb VIA_ORA

        rts
.endproc
.export _spi_end := spi_end
