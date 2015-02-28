.include "globals.inc"

.segment "OSZP": zeropage
ptr1:		.res 2
tmp1:		.res 1

.segment "BSS"
line_buffer:	.res LINE_BUFFER_SIZE

