; Useful macros

; ===========================================================================
; 16-bit mode

; Enable 16-bit accumulator and index
.macro set_16
	rep #$30
	.a16
	.i16
.endmacro

; Disable 16-bit accumulator and index
.macro reset_16
	.i8
	.a8
	sep #$30
.endmacro

; ===========================================================================
; Immediate loading

; Load an absolute 16-bit value into A (low byte) and X (high byte)
.macro ldax_abs val
	lda #<(val)
	ldx #>(val)
.endmacro

; Load an absolute 16-bit value into a word in memory
.macro ldw Addr, val
	pha
	lda #<(val)
	sta Addr
	lda #>(val)
	sta Addr+1
	pla
.endmacro

; ===========================================================================
; Copying

; Copy 16-bit word from Addr2 to Addr1. Preserves A via stack.
.macro copy_word Addr1, Addr2
	pha
	lda Addr2
	sta Addr1
	lda Addr2+1
	sta Addr1+1
	pla
.endmacro

; ===========================================================================
; Arithmetic

; Add without carry. Like adc but clear carry bit first
.macro add Arg
	clc
	adc Arg
.endmacro

; Subtrct without carry. Like sbc but set carry bit first
.macro sub Arg
	sec
	sbc Arg
.endmacro

; Add the byte in A to the 16-byte value at Addr with carry. Preserves A using
; stack.
.macro adc_word Addr
	pha
	adc Addr
	sta Addr
	lda #0
	adc Addr+1
	sta Addr+1
	pla
.endmacro

; Like adc_word but clears carry bit first.
.macro add_word Addr
	clc
	adc_word Addr
.endmacro

; Increment the 16-bit value at Addr
.macro inc_word Addr
	.local @SkipHighInc
	inc Addr			; increment low byte
	bne @SkipHighInc		; if non zero, don't increment high byte
	inc Addr+1			; increment high byte
@SkipHighInc:
.endmacro

; ===========================================================================
; Store a C-style string
.macro cstring Str
	.byte Str, 0
.endmacro

; ===========================================================================
; Store a Pascal-style string
.macro pstring Str
	.byte .strlen(Str), Str
.endmacro

; ===========================================================================
; Stack manipulation. Macro-ised to avoid silly mistakes w.r.t. ordering of
; push and pulls.

; Save/restor data bank and direct page registers
.macro save_bd
	phb
	phd
.endmacro

.macro restore_bd
	pld
	plb
.endmacro

; Save/restore X, Y on entry/exit
.macro save_xy
	phx
	phy
.endmacro
.macro restore_xy
	ply
	plx
.endmacro

; Save/restore 8-bit value at Addr. CORRUPTS Y
.macro save_byte Addr
	ldy Addr
	phy
.endmacro
.macro restore_byte Addr
	ply
	sty Addr
.endmacro

; Save/restore 16-bit value at Addr. CORRUPTS Y
.macro save_word Addr
	ldy Addr
	phy
	ldy Addr+1
	phy
.endmacro
.macro restore_word Addr
	ply
	sty Addr+1
	ply
	sty Addr
.endmacro

; ===========================================================================
; Command table

; Register command Name with entry point at Addr in the command table.
; e.g.: registercmd "foo" fooentry
.macro registercmd Name, Addr
.pushseg
.segment "CMDTBL"
	; Total length of entry including this byte
	.byte 1 + 2 + .strlen(Name) + 1
	; Address of entry point
	.word Addr
	; C-style command name
	cstring Name
.popseg
.endmacro

; vi:ft=asm
