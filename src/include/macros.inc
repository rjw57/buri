; Useful macros

; ===========================================================================
; 8-bit/16-bit mode

; Set accumulator to 8-bit mode
.macro m8
	sep	#$20
	.a8
.endmacro

; Set accumulator to 16-bit mode
.macro m16
	rep	#$20
	.a16
.endmacro

; Set index to 8-bit mode
.macro x8
	sep	#$10
	.i8
.endmacro

; Set index to 16-bit mode
.macro x16
	rep	#$10
	.i16
.endmacro

; Set accumulator & index to 8-bit mode
.macro mx8
	sep	#$30
	.a8
	.i8
.endmacro

; Set accumulator & index to 16-bit mode
.macro mx16
	rep	#$30
	.a16
	.i16
.endmacro

; ===========================================================================
; Emulation mode

; Enable emulation mode
.macro set_emulation
	sec
	xce
.endmacro

; Enable native moe
.macro set_native
	clc
	xce
.endmacro

; vi:ft=asm_ca65
