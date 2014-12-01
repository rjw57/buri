;
; Define OS-reserved region of zeropage
;

.segment "OSZP": zeropage

sp:	.res 2

; Temporary-use pointers and variables. These need not be preserved across
; function calls.
ptr1:	.res 2
ptr2:	.res 2
tmp1:	.res 2
tmp2:	.res 2
tmp3:	.res 2
