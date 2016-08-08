.export adc_word_byte

.importzp tmp1

; Add with carry the byte in tmp1 to the 16-bit word in A,X. A is the low byte,
; X the high byte.
;
; i.e.: AX = AX + tmp1 + C
.proc adc_word_byte
	adc tmp1		; A = A + C + tmp1
	bcc @exit		; no carry? we're done
	inx			; if we have carry, increment X
@exit:
	rts
.endproc
