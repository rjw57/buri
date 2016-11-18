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
.include "macros.inc"

.importzp tmp1, tmp2
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
check_input:
        pha                             ; save value on stack
        lda #$20                        ; direction?
        and spi_begin_arg
        bne @norev                      ; 1 => MSB first
        pla
        jsr reverse
        bra @done
@norev:
        pla
@done:

        ldy #0                          ; Y <- recv. byte
        ldx #8
send_loop:
        pha                             ; Y >>= 1
        tya
        asl
        tay
        pla

        asl                             ; C <- high bit of accum

        phx                             ; Exchange bits in carry flag
        pha
        phy
        jsr spi_exchange_bit
        bcc @recv0
@recv1:
        pla
        ora #$01
        tay
        bra @done
@recv0:
        ply
@done:
        pla
        plx

        dex
        bne send_loop

        tya                             ; A <- output byte

check_output:
        pha                             ; save value on stack
        lda #$20                        ; direction?
        and spi_begin_arg
        bne @norev                      ; 1 => MSB first
        pla
        jsr reverse
        bra @done
@norev:
        pla
@done:

        rts
.endproc
.export _spi_exchange := spi_exchange

; =========================================================================
; spi_exchange_bit: exchange single bit on SPI bus
;       C flag - bit to send
;
; On exit the C flag is set to the recieved bit
; =========================================================================
.proc spi_exchange_bit

        ldx #0                          ; X <- MOSI mask or 0
        bcc send0
        ldx #MOSI_MASK
send0:

        ldy #0                          ; Y <- received bit

        lda #$40                        ; test CPHA
        bit spi_begin_arg
        bne cpha1
cpha0:
        jsr recv
        jsr toggle_clk
        jsr send
        bra done
cpha1:
        jsr send
        jsr toggle_clk
        jsr recv
done:
        jsr toggle_clk

        clc                             ; clear carry flag
        tya                             ; A <- received bit
        beq recv0                       ; A == 0, don's set carry
        sec
recv0:

        rts

        ; These are "sub-subroutines" :)
toggle_clk:
        lda #$01                        ; toggle clock line
        eor VIA_ORA
        sta VIA_ORA
        rts

recv:
        lda #MISO_MASK
        and VIA_ORA
        tay
        rts

send:
        lda #MOSI_MASK
        trb VIA_ORA
        txa
        tsb VIA_ORA
        rts
.endproc

; Reverse bits in the accumulator
.proc reverse
        xba                             ; B will hold result
        lda #0
        xba

        ldx #8
loop:
        xba                             ; B >>= 1
        lsr
        xba
        asl                             ; A <<= 1, C = high bit
        bcc next                        ; C == 0, continue
        xba                             ; C == 1, B |= 0x80
        ora #$80
        xba
next:
        dex
        bne loop

        xba                             ; A <- B

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
