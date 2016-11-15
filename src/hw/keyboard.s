; Device driver for PS/2 keyboard attached to 6522 VIA.
.include "macros.inc"

.import irq_first_handler

; The Búri keyboard is attached to the 6522 VIA's port A. When a new byte is
; available, it is presented on port A and CA1 is pulsed.

VIA_BASE = $DEF0
VIA_ORA = VIA_BASE + 1
VIA_IFR = VIA_BASE + 13
VIA_IER = VIA_BASE + 14

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
.proc keyboard_irq_handler
@test:
        lda #$02                        ; is interrupt due to keyboard?
        bit VIA_IFR
        beq @next                       ; no, jump to next handler
        lda VIA_ORA                     ; read keyboard byte from VIA

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
; keyboard_read: read incoming scan code byte from keyboard
;
; Sets A to byte and X to 0 if byte present to read. Sets A and X to $FF if
; there's no byte
;
; C: i16 keyboard_read(void)
; =========================================================================
.export keyboard_read
.proc keyboard_read
        lda keyboard_buf_count          ; keyboard buffer empty?
        bne @buf_non_empty              ; no, pop value
        lda #$FF                        ; yes, return no code
        tax
        rts
@buf_non_empty:

        lda keyboard_buf                ; store next byte on stack
        pha

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
.export _keyboard_read := keyboard_read

; =========================================================================
; keyboard_init: initialise the keyboard hardware
;
; C: void keyboard_init(void)
; =========================================================================
.export keyboard_init
.proc keyboard_init
        irq_add_handler keyboard_irq_handler, next_handler

        stz keyboard_buf_count          ; no bytes in keyboard buffer

        lda #$02                        ; enable interrupt on CA1 active edge
        tsb VIA_IER

        rts
.endproc
.export _keyboard_init := keyboard_init
