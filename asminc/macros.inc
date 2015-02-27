; Useful macros

; ===========================================================================
; Load an immediate 16-bit value into A (low byte) and X (high byte)
.macro ldaxi val
	lda #<(val)
	ldx #>(val)
.endmacro

; ===========================================================================
; Store a C-style string
.macro cstring Str
	.byte Str
	.byte 0
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

; vi:ft=asm
