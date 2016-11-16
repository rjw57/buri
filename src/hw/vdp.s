; Device driver for VDP
.include "macros.inc"

.import irq_first_handler

; Memory-mapped data and control ports
VDP_DATA                = $DE00
VDP_CTRL                = $DE01
.export VDP_DATA, VDP_CTRL

; VRAM addresses of fixed tables
VDP_PAT_TBL_BASE        = $0000
VDP_NAM_TBL_BASE        = $0800
.export VDP_PAT_TBL_BASE, VDP_NAM_TBL_BASE

; Set VRAM address to assemble-time constant value
.macro vdp_set_vram addr
        lda #<(addr)
        sta VDP_CTRL
        lda #(((>(addr)) & $3F) | $40)
        sta VDP_CTRL
.endmacro

.bss

; A counter incremented on every VBLANK IRQ. ~50Hz
vdp_tick: .res 2
.export vdp_tick

; Next IRQ handler routine to pass control to after vdp_irq_handler is finished.
next_handler: .res 2

.code

; =========================================================================
; vdp_init: initialise VDP after reset
;
; C: void vdp_init(void)
; =========================================================================
.export vdp_init
.proc vdp_init
        irq_add_handler vdp_irq_handler, next_handler

        jsr vdp_clear_vram
        jsr vdp_load_font

        ldy #7
@loop:
        ldx VDP_INIT_TAB, Y
        tya
        jsr vdp_set_reg
        dey
        bpl @loop

        vdp_set_vram VDP_NAM_TBL_BASE

        rts
.endproc
.export _vdp_init := vdp_init

; =========================================================================
; vdp_write_data: write byte to data register
;
; C: void vdp_write_data(u8 value)
; =========================================================================
.export vdp_write_data
.proc vdp_write_data
        sta VDP_DATA
        rts
.endproc
.export _vdp_write_data = vdp_write_data

; =========================================================================
; vdp_set_write_addr: set VRAM write address
;       A - low byte of address
;       X - high byte of address
;
; C: void vdp_set_write_addr(u16 addr)
; =========================================================================
.export vdp_set_write_addr
.proc vdp_set_write_addr
        sta VDP_CTRL
        txa
        and #$3F
        ora #$40
        sta VDP_CTRL
        rts
.endproc
.export _vdp_set_write_addr := vdp_set_write_addr

; =========================================================================
; vdp_set_read_addr: set VRAM read address
;       A - low byte of address
;       X - high byte of address
;
; C: void vdp_set_read_addr(u16 addr)
; =========================================================================
.export vdp_set_read_addr
.proc vdp_set_read_addr
        sta VDP_CTRL
        txa
        and #$3F
        sta VDP_CTRL
        rts
.endproc
.export _vdp_set_read_addr := vdp_set_read_addr

; =========================================================================
; vdp_read_data: read byte from data register
;
; C: u8 vdp_read_data(void)
; =========================================================================
.export vdp_read_data
.proc vdp_read_data
        lda VDP_DATA
        rts
.endproc
.export _vdp_read_data = vdp_read_data

; =========================================================================
; vdp_write_ctrl: write byte to control register
;       A - value
; =========================================================================
.export vdp_write_ctrl
.proc vdp_write_ctrl
        sta VDP_CTRL
        rts
.endproc

; =========================================================================
; vdp_set_reg:
;       A - register to set
;       X - value
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
        lda #$40                ; VRAM write address -> $0000
        stz VDP_CTRL
        sta VDP_CTRL

        x16                     ; index reg -> 16 -bit
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
        vdp_set_vram VDP_PAT_TBL_BASE + $20*8

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
; vdp_irq_handler: handle VDP interrupt
; =========================================================================
.export vdp_irq_handler
.proc vdp_irq_handler
test:
        lda #$80                        ; F flag set in status register?
        bit VDP_CTRL
        beq done

        m16
        inc vdp_tick
        m8

        bra test
done:
        jmp (next_handler)
.endproc

; =========================================================================
; VDP_INIT_TAB: initial register values for VDP
;
; Text mode, interrupt enable, set fg/bg color, pattern @ 0x0000, name @ 0x0800
; =========================================================================
VDP_INIT_TAB:
        .byte $00, $F0, $02, $00, $00, $00, $00, $21

; =========================================================================
; VDP_FONT_TAB: font table for VDP
;
; ASCII font from $20 to $FF (incl.)
; =========================================================================
VDP_FONT_TAB:
        .incbin "font6x8.raw"
VDP_FONT_TAB_END:
VDP_FONT_TAB_SIZE = VDP_FONT_TAB_END - VDP_FONT_TAB
