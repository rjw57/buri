;
; Global state for OS
;
.include "globals.inc"

; Zero page
.segment "OSZP": zeropage

ptr1:		.res 2
ptr2:		.res 2
tmp1:		.res 2
tmp2:		.res 2
tmp3:		.res 2

tx:		.res 1
ty:		.res 1
taddr:		.res 2

acia1_recv_data:	.res 1

line_len:	.res 1			; # bytes in input line buffer
srl_buf_len:	.res 1			; # bytes in serial input buffer
srl_buf_start:	.res 1			; offset into serial buffer of start

; Non zeropage storage
.segment "BSS"
line_buffer:	.res	MAX_LINE	; input line
srl_buffer:	.res	SRL_BUF_SZ	; serial port input buffer

