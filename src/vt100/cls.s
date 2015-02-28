.include "ascii.inc"
.include "macros.inc"

.import puts

; cls - clear the terminal screen
.global cls
.proc cls
	pha
	save_xy
	ldax_abs cls_str	; load string address
	jsr puts
	restore_xy
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
