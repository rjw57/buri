.include "macros.inc"

.importzp sreg

; =========================================================================
; parse_hex_4: parse nibble from character
;       A - ASCII character to parse
;
; On exit A is parsed nibble. Carry is set on parse error, clear otherwise.
;
; C: i16 parse_hex_4(u8 c)
;
; Error is indicated by -ve return value.
; =========================================================================
.export parse_hex_4
.proc parse_hex_4
        tax                             ; stash copy of A in X

        sub #'0'                        ; try '0' to '9'
        bmi not_digit
        cmp #10
        bge not_digit                   ; success
        clc
        rts
not_digit:

        txa                             ; restore A
        sub #'A'                        ; try 'A' to 'F'
        bmi not_uc
        cmp #6
        blt letter_success
not_uc:

        txa                             ; restore A
        sub #'a'                        ; try 'a' to 'f'
        bmi not_lc
        cmp #6
        blt letter_success
not_lc:
        sec                             ; parse error
        rts
letter_success:                         ; successful letter parsse
        add #10
        clc
        rts
.endproc
.export _parse_hex_4
.proc _parse_hex_4
        jsr parse_hex_4
        ldx #$00
        bcc success
        ldx #$FF
success:
        rts
.endproc

; =========================================================================
; parse_hex_32: parse hex value in string
;       A - low byte of string in memory
;       X - high byte of string in memory
;
; On exit:
;       A - low byte of parse result
;       X - next byte of parse result
;       sreg - high two bytes of parse result (little endian)
;
;       C flag - set on parse error/overflow, clear otherwise
; =========================================================================
.export parse_hex_32
.proc parse_hex_32
        ; Stack layout for function
        ;
        ; 7,S - two byte string address (LE)
        ; 6,S - parse nibble
        ; 5,S - loop counter
        ; 1,S - four byte result (LE)

        phx                             ; push high byte of address
        pha                             ; push low byte of address

        m16                             ; make room in stack
        tsa
        sub #6
        tas

        lda #0
        sta 1,S                         ; clear stack
        sta 3,S
        sta 5,S

        m8

read_loop:
        lda 5,S                         ; load loop counter
        tay
        lda (7,S),Y                     ; load next char
        beq done                        ; finished on terminator

        jsr parse_hex_4                 ; parse nibble
        bcs fail                        ; parse error
        sta 6,S                         ; save nibble

        m16
        ldx #0                          ; shift output 4 to left
shift_loop:
        lda 1,S                         ; low 16-bits of result
        asl
        sta 1,S                         ; store result
        lda 3,S                         ; high 16-bits of result
        rol                             ; shift copying in carry flag
        sta 3,S                         ; store high 16-bits of result

        inx                             ; next iteration
        cpx #4
        bne shift_loop
        m8

        lda 6,S                         ; restore nibble
        ora 1,S                         ; or with low byte
        sta 1,S                         ; save low byte

        lda 5,S                         ; increment index
        inc
        sta 5,S
        bra read_loop                   ; continue
done:
        m16
        lda 3,S                         ; high 16-bits
        sta sreg                        ; store in sreg
        lda 1,S                         ; low 16-bits
        m8

        tay                             ; stash low 8-bits of A in Y
        xba
        tax                             ; high 8-bits in X

        m16
        tsa                             ; restore stack pointer
        add #8
        tas
        m8

        tya                             ; restore A = low 8-bits

        clc
        rts
fail:
        m16
        tsa                             ; restore stack
        add #8
        tas
        m16
        m8
        sec                             ; signal failure
        rts
.endproc

; =========================================================================
; C: i16 parse_hex_8(const char* s)
;
; Returns -ve value on parse error.
; =========================================================================
.export _parse_hex_8
.proc _parse_hex_8
        jsr parse_hex_32
        bcs fail
        cpx #$00
        bne fail
        rts
fail:
        ldx #$FF
        rts
.endproc

; =========================================================================
; C: i32 parse_hex_16(const char* s)
;
; Returns -ve value on parse error.
; =========================================================================
.export _parse_hex_16
.proc _parse_hex_16
        jsr parse_hex_32
        bcs fail
        ldy sreg
        bnz fail
        rts
fail:
        lda #$FF
        sta sreg+1
        rts
.endproc

; =========================================================================
; C: i32 parse_hex_24(const char* s)
;
; Returns -ve value on parse error.
; =========================================================================
.export _parse_hex_24
.proc _parse_hex_24
        jsr parse_hex_32
        bcs fail
        ldy sreg+1
        bnz fail
        rts
fail:
        lda #$FF
        sta sreg+1
        rts
.endproc
