.include "macros.inc"

.export puthex

.import putc
.importzp tmp1

; puthex - write a single byte as a two-digit hex value
;
; on entry:
; 	A - byte to write
; on exit:
; 	A - preserved
.proc puthex
	pha
	save_xy
	save_byte tmp1

	sta tmp1		; original value in tmp1
	
	lsr			; shift upper nibble down
	lsr
	lsr
	lsr
	jsr putdigit		; output

	lda #$0F		; load lower nibble
	and tmp1
	jsr putdigit		; output
	
	restore_byte tmp1
	restore_xy
	pla
	rts
.endproc

; INTERNAL proc - output single hex digit. Requires A <= $0F.
.proc putdigit
	cmp #$0A		; >= $A?
	bcs @letter		; yes, use letter
@digit:
	clc			; no, use digit
	adc #'0'
	bra @exit
@letter:
	clc
	adc #'A'-$A
@exit:
	jsr putc
	rts
.endproc
