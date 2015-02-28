.include "ascii.inc"
.include "macros.inc"

.import puts

; initscr - reset the terminal to its default state
.global initscr
.proc initscr
	pha
	save_xy
	lda #<reset_str		; load string address
	ldx #>reset_str
	jsr puts
	restore_xy
	pla
	rts
.endproc

.segment "RODATA"
reset_str:
	.byte ASCII_ESC
	.byte 'c'
	.byte 0
