; Console keyboard support
.include "macros.inc"

.import keyboard_get_next_scancode

.bss

; Private flag byte containing modifiers from MSB to LSB:
;
; (reserved) (reserved) LShift LCtrl LAlt RAlt RCtrl RShift
console_modifiers: .res 1

CONSOLE_RSHIFT_MASK = $01
CONSOLE_RCTRL_MASK = $02
CONSOLE_RALT_MASK = $04
CONSOLE_LALT_MASK = $08
CONSOLE_LCTRL_MASK = $10
CONSOLE_LSHIFT_MASK = $20

CONSOLE_SHIFT_MASK = CONSOLE_LSHIFT_MASK | CONSOLE_RSHIFT_MASK
CONSOLE_CTRL_MASK = CONSOLE_LCTRL_MASK | CONSOLE_RCTRL_MASK
CONSOLE_ALT_MASK = CONSOLE_LALT_MASK | CONSOLE_RALT_MASK

.code

; =========================================================================
; console_read_char: retrieve next ASCII character from keyboard
;
; If a key has been pressed since the last call to console_read_char, the ASCII
; value is written to A and X is set to $00. If no key has been pressed A and X
; are both set to $FF.
;
; C: i16 console_read_char(void)
; =========================================================================
.export console_read_char
.proc console_read_char
loop:
        jsr keyboard_get_next_scancode  ; A, X = next scancode
        cpx #$00                        ; X != 0?
        bne nochar                      ; if so, no character to read

        cmp #$00                        ; swallow $00 codes
        beq loop
        cmp #$E0                        ; swallow $E0 codes
        beq loop

        ldy #$00                        ; check code against modifier table
modifier_loop:
        pha                             ; X <- modifier mask
        lda CONSOLE_MODIFIER_TAB+2, Y
        tax
        pla

        cmp CONSOLE_MODIFIER_TAB, Y     ; make scancode?
        bne @notmake
        txa
        tsb console_modifiers
        bra loop
@notmake:
        cmp CONSOLE_MODIFIER_TAB+1, Y   ; break scancode?
        bne @continue
        txa
        trb console_modifiers
        bra loop
@continue:
        iny                             ; advance to next record
        iny
        iny
        cpy #CONSOLE_MODIFIER_TAB_LEN
        blt modifier_loop

        mx16                            ; 16-bit mode
        and #$00FF                      ; mask off high bits from A
        asl                             ; multiply by two to get offset
        tax                             ; set X = A
        m8                              ; accumulator back to 8-bit

        lda #CONSOLE_SHIFT_MASK         ; shift pressed?
        bit console_modifiers
        beq noshift
        inx                             ; shift => increment index by 1
noshift:

        cpx #CONSOLE_ASCII_TAB_LEN      ; compare index to table length
        blt validcode                   ; valid: branch
        x8                              ; invalid: restore 8-bit index
        bra loop                        ; see if there are more scancodes

validcode:
        lda CONSOLE_ASCII_TAB, X        ; load ASCII translation
        x8                              ; restore 8-bit index

        cmp #0                          ; NUL code?
        beq loop                        ; yes, see if there are more scancodes

        rts
nochar:                                 ; return "no character"
        lda #$FF 
        tax
        rts
.endproc
.export _console_read_char := console_read_char

; =========================================================================
; CONSOLE_ASCII_TAB: table mapping scancodes into lower and uppercase ASCII
; =========================================================================
CONSOLE_ASCII_TAB:
        .byte $00, $00 ; $00
        .byte $1B, $1B ; $01 - Escape
        .byte "1!2@3#4$5%6^7&8*9(0)-_=+" ; $02-$0D
        .byte $08, $08, $09, $09 ; $0E-$)F - Backspace, Tab
        .byte "qQwWeErRtTyYuUiIoOpP[{]}" ; $10-$1B
        .byte $0D, $0D, $00, $00 ; $1C-$1D - Enter, Left ctrl
        .byte "aAsSdDfFgGhHjJkKlL;:'", '"', "'~" ; $1E-$29
        .byte $00, $00 ; $2A - Left shift
        .byte "\|zZxXcCvVbBnNmM,<.>/?" ; $2B-$35
        .byte $00, $00, $00, $00, $00, $00 ; $36-$38 - R shift, PrtScrn, L alt
        .byte " " ; $39
CONSOLE_ASCII_TAB_END:
CONSOLE_ASCII_TAB_LEN = CONSOLE_ASCII_TAB_END - CONSOLE_ASCII_TAB

; =========================================================================
; CONSOLE_MODIFIER_TAB: table mapping scancodes to modifier masks
;
; This table is used to set modifier masks depending on scan code. Each record
; is three bytes long and corresponds to make code, break code, modifier mask to
; set/reset for the make/break scancode.
; =========================================================================
CONSOLE_MODIFIER_TAB:
        .byte $2A, $AA, CONSOLE_LSHIFT_MASK
        .byte $36, $B6, CONSOLE_RSHIFT_MASK
        .byte $1D, $9D, CONSOLE_LCTRL_MASK
        .byte $38, $B8, CONSOLE_LALT_MASK
CONSOLE_MODIFIER_TAB_END:
CONSOLE_MODIFIER_TAB_LEN = CONSOLE_MODIFIER_TAB_END - CONSOLE_MODIFIER_TAB

