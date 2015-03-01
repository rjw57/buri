.include "ascii.inc"
.include "macros.inc"

.importzp ptr1
.import puts

; initscr - reset the terminal to its default state
.global initscr
.proc initscr
	pha
	save_word ptr1
	ldw ptr1, reset_str
	jsr puts
	restore_word ptr1
	pla
	rts
.endproc

.segment "RODATA"
reset_str:
	.byte ASCII_ESC
	.byte 'c'
	.byte 0
