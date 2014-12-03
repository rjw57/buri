;
; Define OS-reserved region of zeropage
;
.include "globals.inc"

.segment "OSZP": zeropage

ptr1:	.res 2
ptr2:	.res 2
tmp1:	.res 2
tmp2:	.res 2
tmp3:	.res 2

acia1_status_cache:	.res 1
