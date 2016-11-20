YM3812_BASE = $DE02
YM3812_ADDR = YM3812_BASE
YM3812_STATUS = YM3812_BASE
YM3812_DATA = YM3812_BASE+1

; Buri startup instrument
;
; FM synthesis
;
; CARRIER:
;   Attack: 12          Freq, mul: 3
;   Decay:  3           Level:     63
;   Sust.:  1           KSL:       2
;   Rel.:   3           Waveform:  0
;
; MODULATOR:
;   Attack: 15          Freq, mul: 5
;   Decay:  1           Level:     21
;   Sust.:  1           KSL:       1
;   Rel.:   5           Waveform:  0
;                       FB:        3

; =========================================================================
; ym3812_init: initialise sound hardware
;
; C: void ym3812_init(void)
; =========================================================================
.export ym3812_init
.proc ym3812_init
        ; Test register
        lda #$00
        ldx #$01
        jsr write_reg

        ; Carrier
        lda #20
        ldx #%00000011
        jsr write_reg
        lda #40
        ldx #%10111111
        jsr write_reg
        lda #60
        ldx #%11000011
        jsr write_reg
        lda #80
        ldx #%00010011
        jsr write_reg

        ; Modulator
        lda #23
        ldx #%00000101
        jsr write_reg
        lda #43
        ldx #%01010101
        jsr write_reg
        lda #63
        ldx #%11110001
        jsr write_reg
        lda #83
        ldx #%00010101
        jsr write_reg

        lda #$A0
        ldx #$FF
        jsr write_reg
        lda #$B0
        ldx #%00110011
        jsr write_reg

        rts
.endproc
.export _ym3812_init := ym3812_init

; A - reg, X value
.proc write_reg
        sta YM3812_ADDR

        ldy #$FF
loop1:
        dey
        bne loop1

        txa
        sta YM3812_DATA

        ldy #$FF
loop2:
        dey
        bne loop2

        rts
.endproc
