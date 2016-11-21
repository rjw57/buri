; 6551 UART controller
.include "macros.inc"
.include "ring_buf.inc"

ACIA_BASE = $DFFC
ACIA_TXRX = ACIA_BASE
ACIA_RST = ACIA_BASE+1
ACIA_STATUS = ACIA_RST
ACIA_CMD = ACIA_BASE+2
ACIA_CTRL = ACIA_BASE+3

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

.bss

ACIA_RECV_RB_LEN = 8
ring_buf_reserve acia6551_recv_buf, ACIA_RECV_RB_LEN

ACIA_SEND_RB_LEN = 4
ring_buf_reserve acia6551_send_buf, ACIA_SEND_RB_LEN

; =========================================================================
; Next IRQ handler routine to pass control to after acia6551_irq_handler is
; finished.
next_handler: .res 2

.code

; =========================================================================
; acia6551_init: initialise driver
;
; C: void acia6551_init(void)
; =========================================================================
.export acia6551_init
.proc acia6551_init
        sta ACIA_RST                    ; reset ACIA

        ring_buf_init acia6551_recv_buf, ACIA_RECV_RB_LEN
        ring_buf_init acia6551_send_buf, ACIA_SEND_RB_LEN

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
        ring_buf_push acia6551_send_buf, ACIA_SEND_RB_LEN
        bcs fail
        enable_tx_irq
        lda #$FF
        rts
fail:
        lda #$00
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
        ; get return value straight from r. buf.
        ring_buf_pop acia6551_recv_buf, ACIA_RECV_RB_LEN
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
        beq recv_done                   ; if empty, we're done

        pha                             ; save status reg.
        lda ACIA_TXRX                   ; A <- received byte
        ; store byte in ring buffer
        ring_buf_push acia6551_recv_buf, ACIA_RECV_RB_LEN
        pla                             ; restore status reg.
recv_done:

        bit #$10                        ; test send. register empty
        beq send_done                   ; full, don't send next byte

        ; pop byte to send from ring buf
        ring_buf_pop acia6551_send_buf, ACIA_SEND_RB_LEN
        bcs buf_empty                   ; if ring buf empty, skip
        sta ACIA_TXRX                   ; send byte
        bra send_done                   ; done
buf_empty:
        disable_tx_irq                  ; send buffer is empty, disable IRQ
send_done:

        bra loop                        ; re-check interrupt flags
exit:
        jmp (next_handler)
.endproc
