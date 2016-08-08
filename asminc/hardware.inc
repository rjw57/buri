; Locations of memory-mapped hardware registers.

.import __IO_START__

; ACIA1 is at *end* of final IO page
ACIA1 		= __IO_START__ + $70 + $0C
ACIA1_DATA 	= ACIA1
ACIA1_STATUS 	= ACIA1 + 1
ACIA1_CMD 	= ACIA1 + 2
ACIA1_CTRL 	= ACIA1 + 3

; ACIA-related constants
ACIA_ST_TDRE = %00010000	; status: transmit data register empty
ACIA_ST_RDRF = %00001000	; status: read data register full

; vi:ft=asm
