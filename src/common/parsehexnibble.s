.include "macros.inc"

.export parsehexnibble

; parsehexnibble - parse hex digit into binary value
;
; on entry:
; 	A - ASCII hex digit to parse
; on exit:
; 	A - value of hex digit in lower nibble
; 	carry - set on error
.proc parsehexnibble
	cmp #'0'			; compare to '0'
	bcc error			; less than, error
	cmp #'9'+1			; compare to '9'+1
	bcc decimal			; less than, it's a decimal digit
	cmp #'A'			; compare to 'A'
	bcc error			; less than, error
	cmp #'F'+1			; compare to 'F'+1
	bcc upper			; less than, it's an uppercase letter
	cmp #'a'			; compare to 'a'
	bcc error			; less than, error
	cmp #'f'+1			; compare to 'f'+1
	bcc lower			; less than, it's an lowercase letter
error:
	sec
	bra exit
decimal:
	sub #'0'			; subtract ASCII '0'
	bra success
upper:
	sub #'A'-$A			; subtract ASCII 'A'
	bra success
lower:
	sub #'a'-$A			; subtract ASCII 'a'
success:
	clc
exit:
	rts
.endproc
