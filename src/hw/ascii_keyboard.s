; Keyboard keyboard support
.include "macros.inc"

.import keyboard_read_next_scancode

.bss

; Private flag byte containing modifiers from MSB to LSB:
;
; (reserved) (reserved) LShift LCtrl LAlt RAlt RCtrl RShift
keyboard_modifiers: .res 1

KEYBOARD_RSHIFT_MASK = $01
KEYBOARD_RCTRL_MASK = $02
KEYBOARD_RALT_MASK = $04
KEYBOARD_LALT_MASK = $08
KEYBOARD_LCTRL_MASK = $10
KEYBOARD_LSHIFT_MASK = $20

KEYBOARD_SHIFT_MASK = KEYBOARD_LSHIFT_MASK | KEYBOARD_RSHIFT_MASK
KEYBOARD_CTRL_MASK = KEYBOARD_LCTRL_MASK | KEYBOARD_RCTRL_MASK
KEYBOARD_ALT_MASK = KEYBOARD_LALT_MASK | KEYBOARD_RALT_MASK

.code

; =========================================================================
; keyboard_read_ascii: retrieve next ASCII character from keyboard
;
; If a key has been pressed since the last call to keyboard_read_ascii, the ASCII
; value is written to A and X is set to $00. If no key has been pressed A and X
; are both set to $FF.
;
; C: i16 keyboard_read_ascii(void)
; =========================================================================
.export keyboard_read_ascii
.proc keyboard_read_ascii
loop:
        jsr keyboard_read_next_scancode  ; A, X = next scancode
        cpx #$00                        ; X != 0?
        bne nochar                      ; if so, no character to read

        cmp #$00                        ; swallow $00 codes
        beq loop
        cmp #$E0                        ; swallow $E0 codes
        beq loop

        ldy #$00                        ; check code against modifier table
modifier_loop:
        pha                             ; X <- modifier mask
        lda KEYBOARD_MODIFIER_TAB+2, Y
        tax
        pla

        cmp KEYBOARD_MODIFIER_TAB, Y     ; make scancode?
        bne @notmake
        txa
        tsb keyboard_modifiers
        bra loop
@notmake:
        cmp KEYBOARD_MODIFIER_TAB+1, Y   ; break scancode?
        bne @continue
        txa
        trb keyboard_modifiers
        bra loop
@continue:
        iny                             ; advance to next record
        iny
        iny
        cpy #KEYBOARD_MODIFIER_TAB_LEN
        blt modifier_loop

        mx16                            ; 16-bit mode
        and #$00FF                      ; mask off high bits from A
        asl                             ; multiply by two to get offset
        tax                             ; set X = A
        m8                              ; accumulator back to 8-bit

        lda #KEYBOARD_SHIFT_MASK         ; shift pressed?
        bit keyboard_modifiers
        beq noshift
        inx                             ; shift => increment index by 1
noshift:

        cpx #KEYBOARD_ASCII_TAB_LEN      ; compare index to table length
        blt validcode                   ; valid: branch
        x8                              ; invalid: restore 8-bit index
        bra loop                        ; see if there are more scancodes

validcode:
        lda KEYBOARD_ASCII_TAB, X        ; load ASCII translation
        x8                              ; restore 8-bit index

        cmp #0                          ; NUL code?
        beq loop                        ; yes, see if there are more scancodes

        rts
nochar:                                 ; return "no character"
        lda #$FF 
        tax
        rts
.endproc
.export _keyboard_read_ascii := keyboard_read_ascii

; =========================================================================
; KEYBOARD_ASCII_TAB: table mapping scancodes into lower and uppercase ASCII
; =========================================================================
KEYBOARD_ASCII_TAB:
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
KEYBOARD_ASCII_TAB_END:
KEYBOARD_ASCII_TAB_LEN = KEYBOARD_ASCII_TAB_END - KEYBOARD_ASCII_TAB

; =========================================================================
; KEYBOARD_MODIFIER_TAB: table mapping scancodes to modifier masks
;
; This table is used to set modifier masks depending on scan code. Each record
; is three bytes long and corresponds to make code, break code, modifier mask to
; set/reset for the make/break scancode.
; =========================================================================
KEYBOARD_MODIFIER_TAB:
        .byte $2A, $AA, KEYBOARD_LSHIFT_MASK
        .byte $36, $B6, KEYBOARD_RSHIFT_MASK
        .byte $1D, $9D, KEYBOARD_LCTRL_MASK
        .byte $38, $B8, KEYBOARD_LALT_MASK
KEYBOARD_MODIFIER_TAB_END:
KEYBOARD_MODIFIER_TAB_LEN = KEYBOARD_MODIFIER_TAB_END - KEYBOARD_MODIFIER_TAB


