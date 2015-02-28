; Useful macros

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

; Save/restore A, X on entry/exit
.macro push_ax
	pha
	phx
.endmacro
.macro pop_ax
	plx
	pla
.endmacro

; Save/restore A, X, Y on entry/exit
.macro push_axy
	pha
	phx
	phy
.endmacro
.macro pop_axy
	ply
	plx
	pla
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
