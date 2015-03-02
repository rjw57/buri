.include "ascii.inc"
.include "macros.inc"

.importzp ptr1
.import puts

; cls - clear the terminal screen
.global cls
.proc cls
	pha
	save_word ptr1
	ldw ptr1, cls_str	; load string address
	jsr puts
	restore_word ptr1
	pla
	rts
.endproc

.segment "RODATA"
cls_str:
	.byte ASCII_ESC
	.byte "[2J"
	.byte ASCII_ESC
	.byte "[H"
	.byte 0
