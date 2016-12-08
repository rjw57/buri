.include "macros.inc"

.importzp ptr1

YM3812_BASE = $DE02
YM3812_ADDR = YM3812_BASE
YM3812_STATUS = YM3812_BASE
YM3812_DATA = YM3812_BASE+1

; =========================================================================
; ym3812_init: initialise sound hardware
;
; C: void ym3812_init(void)
; =========================================================================
.export ym3812_init
.proc ym3812_init
        ldx #$00                        ; clear all YM3812 registers to 0
clear_loop:
        phx
        lda #$00
        jsr ym3812_write_reg
        plx
        inx
        bne clear_loop

        jmp ym3812_beep                 ; tail-call
.endproc
.export _ym3812_init := ym3812_init

; =========================================================================
; ym3812_write_reg: write value to a YM3812 register
;
;       A - value to write
;       X - register to set
; =========================================================================
.proc ym3812_write_reg
        stx YM3812_ADDR
        sta YM3812_DATA
        rts
.endproc

; =========================================================================
; ym3812_beep: emit a system beep
; =========================================================================
.proc ym3812_beep
        ldy #$00
set_loop:
        ldx YM3812_DEF_INST_TBL, Y
        iny

        lda YM3812_DEF_INST_TBL, Y
        iny

        phy
        jsr ym3812_write_reg
        ply

        cpy #YM3812_DEF_INST_TBL_LEN
        blt set_loop

        ldx #$A0
        ldx #$6D
        jsr ym3812_write_reg
        ldx #$B0
        lda #$20 | ($5<<2) | $1
        jmp ym3812_write_reg            ; tail-call
.endproc

; =========================================================================
; Buri system beep instrument
;
; FM synthesis
;
; MODULATOR:
;   Attack: 15          Freq, mul: 5
;   Decay:  1           Level:     21 (needs inverting)
;   Sust.:  1           KSL:       1
;   Rel.:   5           Waveform:  0
;
; CARRIER:
;   Attack: 12          Freq, mul: 3
;   Decay:  3           Level:     63 (needs inverting)
;   Sust.:  1           KSL:       2
;   Rel.:   3           Waveform:  0
;                       FB:        3

YM3812_DEF_INST_TBL:
        .byte $20, $03, $40, $2A, $60, $F1, $80, $15
        .byte $23, $05, $43, $00, $63, $C3, $83, $13
        .byte $C0, $0E
YM3812_DEF_INST_TBL_END:
YM3812_DEF_INST_TBL_LEN = YM3812_DEF_INST_TBL_END - YM3812_DEF_INST_TBL
