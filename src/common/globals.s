.include "globals.inc"

.segment "OSZP": zeropage
cmdname:	.res 1
arg1:		.res 1
arg2:		.res 1
arg3:		.res 1

acia_sr:	.res 1

brk_signature:	.res 1

.segment "BSS"
irq_vector:	.res 2
nmi_vector:	.res 2
brk_vector:	.res 2
line_buffer:	.res LINE_BUFFER_SIZE
