.include "ascii.inc"

.import puts

; initscr - reset the terminal to its default state
.global initscr
.proc initscr
	lda #<reset_str		; load string address
	ldx #>reset_str
	jmp puts		; jump straight to puts letting
				; its rts return
.endproc

.segment "RODATA"
reset_str:
	.byte ASCII_ESC
	.byte 'c'
	.byte 0
