.include "ascii.inc"

.import puts

; cls - clear the terminal screen
.global cls
.proc cls
	lda #<cls_str		; load string address
	ldx #>cls_str
	jmp puts		; jump straight to puts letting
				; its rts return
.endproc

.segment "RODATA"
cls_str:
	.byte ASCII_ESC
	.byte "[2J"
	.byte ASCII_ESC
	.byte "[H"
	.byte ASCII_NUL
