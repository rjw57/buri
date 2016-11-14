; Device driver for VDP
.include "macros.inc"

; Memory-mapped data and control ports
VDP_DATA = $DE00
VDP_CTRL = $DE01

; VRAM addresses of fixed tables
VDP_PATTERN = $0000
VDP_NAME    = $0800

; Set VRAM address to assemble-time constant value
.macro vdp_set_vram addr
	lda #<(addr)
	sta VDP_CTRL
	lda #(((>(addr)) & $3F) | $40)
	sta VDP_CTRL
.endmacro

; =========================================================================
; vdp_init: initialise VDP after reset
;
; C: void vdp_init(void)
; =========================================================================
.export vdp_init
.proc vdp_init
	jsr vdp_clear_vram
	jsr vdp_load_font

	ldy #7
@loop:
	ldx VDP_INIT_TAB, Y
	tya
	jsr vdp_set_reg
	dey
	bpl @loop

	vdp_set_vram VDP_NAME

	rts
.endproc
.export _vdp_init := vdp_init

; =========================================================================
; vdp_write_char: write a character to output
;
; C: void vdp_write_char(u8 ch)
; =========================================================================
.export vdp_write_char
.proc vdp_write_char
	sta VDP_DATA
	rts
.endproc
.export _vdp_write_char = vdp_write_char

; =========================================================================
; vdp_set_reg:
; 	A - register to set
; 	X - value
; =========================================================================
.proc vdp_set_reg
	stx VDP_CTRL
	ora #$80
	sta VDP_CTRL
	rts
.endproc

; =========================================================================
; vdp_clear_vram: set VRAM contents to zero
; =========================================================================
.proc vdp_clear_vram
	lda #$40		; VRAM write address -> $0000
	stz VDP_CTRL
	sta VDP_CTRL

	x16			; index reg -> 16 -bit
	ldx #$8000
@loop:
	stz VDP_DATA
	dex
	bne @loop
	x8

	rts
.endproc

; =========================================================================
; vdp_load_font: load font into pattern table
; =========================================================================
.proc vdp_load_font
	vdp_set_vram VDP_PATTERN + $20*8

	x16
	ldx #0
@loop:
	lda VDP_FONT_TAB, X
	sta VDP_DATA
	inx
	cpx #VDP_FONT_TAB_SIZE
	bne @loop
	x8

	rts
.endproc

; =========================================================================
; VDP_INIT_TAB: initial register values for VDP
;
; Text mode, green bg, white fg, pattern @ 0x0000, name @ 0x0800
; =========================================================================
VDP_INIT_TAB:
	.byte $00, $D0, $02, $00, $00, $00, $00, $FC

; =========================================================================
; VDP_FONT_TAB: font table for VDP
;
; ASCII font from $20 to $FF (incl.)
; =========================================================================
VDP_FONT_TAB:
	.incbin "font6x8.raw"
VDP_FONT_TAB_END:
VDP_FONT_TAB_SIZE = VDP_FONT_TAB_END - VDP_FONT_TAB
