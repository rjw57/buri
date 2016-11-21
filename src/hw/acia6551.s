; 6551 UART controller
.include "macros.inc"

ACIA_BASE = $DFFC
ACIA_TXRX = ACIA_BASE
ACIA_RST = ACIA_BASE+1
ACIA_STATUS = ACIA_RST
ACIA_CMD = ACIA_BASE+2
ACIA_CTRL = ACIA_BASE+3

.bss

.macro disable_tx_irq
        lda ACIA_CMD
        and #%11110011
        ora #%00001000
        sta ACIA_CMD
.endmacro

.macro enable_tx_irq
        lda ACIA_CMD
        and #%11110011
        ora #%00000100
        sta ACIA_CMD
.endmacro

; =========================================================================
; Next IRQ handler routine to pass control to after acia6551_irq_handler is
; finished.
next_handler: .res 2

ACIA_SEND_BUF_LEN = 4
ACIA_RECV_BUF_LEN = 4

send_buf: .res ACIA_SEND_BUF_LEN
recv_buf: .res ACIA_RECV_BUF_LEN
send_buf_size: .res 1
recv_buf_size: .res 1

.code

; =========================================================================
; acia6551_init: initialise driver
;
; C: void acia6551_init(void)
; =========================================================================
.export acia6551_init
.proc acia6551_init
        sta ACIA_RST                    ; reset ACIA

        stz send_buf_size
        stz recv_buf_size

        irq_add_handler acia6551_irq_handler, next_handler

        lda #%00011110                  ; 8-bit, 1 stop, 9600 baud
        sta ACIA_CTRL
        lda #%00001001                  ; No parity, enable hw, rx irq
        sta ACIA_CMD

        rts
.endproc
.export _acia6551_init = acia6551_init

; =========================================================================
; acia6551_send_byte: send a byte over the serial connection
;       A - byte to send
;
; On exit: A is zero if send buffer was full, non-zero otherwise
;
; The sending happens asynchronously via a send buffer. The caller can detect a
; full buffer condition by examining the return value and retry if necessary.
;
; C: u8 acia6551_send_byte(u8)
; =========================================================================
.export acia6551_send_byte
.proc acia6551_send_byte
        tay                             ; Y <- byte to send

        ; We disable and re-enable interrupts here to make sure the IRQ handler
        ; does not modify send_buf. Consider this poor-man's locking.
        sei                             ; disable interrupts

        lda send_buf_size               ; check we have space
        cmp #ACIA_SEND_BUF_LEN
        blt have_space
        cli                             ; re-enable interrupts and return
        lda #$00                        ; failure
        rts
have_space:

        ldx send_buf_size               ; write buffer to send to send buf
        tya
        sta send_buf, X
        inc send_buf_size

        enable_tx_irq                   ; make sure the TX interrupt is enabled

        cli                             ; enable interrupts

        rts
.endproc
.export _acia6551_send_byte = acia6551_send_byte

; =========================================================================
; acia6551_recv_byte: receive a byte from the serial port
;
; On exit: A is received byte. The C flag indicates whether there was a byte to
;          receive. If C is set, there was no byte. If C is clear the byte is
;          valid.
;
; C: i16 acia6551_recv_byte(void)
;
;    Return value is -ve if no byte was received.
; =========================================================================
.export acia6551_recv_byte
.proc acia6551_recv_byte
        sei                             ; disable interrupt

        lda recv_buf_size               ; check recv. buffer size
        bne not_empty

        cli                             ; if empty, re-enable interrupts
        sec                             ; set C flag
        rts                             ; exit

not_empty:
        lda recv_buf                    ; push recv. byte on stack
        pha
        dec recv_buf_size               ; decrement recv. buf size

        mx16                            ; shuffle recv. buffer
        lda #ACIA_RECV_BUF_LEN-2
        ldx #recv_buf+1
        ldy #recv_buf
        mvn $00, $00
        mx8

        pla                             ; restore recv. byte
        clc                             ; clear carry

        rts
.endproc

; C thunk
.export _acia6551_recv_byte
.proc _acia6551_recv_byte
        jsr acia6551_recv_byte

        ldx #$00                        ; handle return value
        bcc exit
        ldx #$FF
        txa
exit:
        rts
.endproc

; =========================================================================
; acia6551_irq_handler: handle ACIA IRQs
; =========================================================================
.export acia6551_irq_handler
.proc acia6551_irq_handler
loop:
        lda ACIA_STATUS                 ; get status reg
        bpl exit                        ; if high bit clear, no interrupt

        bit #$08                        ; test recv. register full
        beq recv_done

        pha                             ; save status reg.
        ldy ACIA_TXRX                   ; Y <- received byte

        lda recv_buf_size               ; is receive buffer full?
        cmp #ACIA_RECV_BUF_LEN
        beq recv_done                   ; yes, drop byte

        ldx recv_buf_size               ; otherwise, store byte
        tya
        sta recv_buf, X

        inc recv_buf_size               ; increment buffer size
        pla                             ; restore status reg.
recv_done:

        bit #$10                        ; test send. register empty
        beq send_done                   ; no, wait for next IRQ

        lda send_buf_size               ; is send buffer empty?
        bne send_non_empty
        disable_tx_irq                  ; send buffer is empty, disable IRQ
        bra send_done

send_non_empty:                         ; send buffer is non empty
        lda send_buf                    ; transmit first char.
        sta ACIA_TXRX
        dec send_buf_size               ; decrement size

        mx16                            ; shuffle buffer down
        lda #ACIA_SEND_BUF_LEN-2
        ldx #send_buf+1
        ldy #send_buf
        mvn $00, $00
        mx8
send_done:

        bra loop                        ; re-check interrupt flags
exit:
        jmp (next_handler)
.endproc
