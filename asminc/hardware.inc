; Constants defining locations of memory-mapped hardware.

ACIA1 		= $DFF0
ACIA1_DATA 	= ACIA1
ACIA1_STATUS 	= ACIA1 + 1
ACIA1_CMD 	= ACIA1 + 2
ACIA1_CTRL 	= ACIA1 + 3

;; Constants
ACIA_ST_TDRE = %00010000	; status: transmit data register empty
ACIA_ST_RDRF = %00001000	; status: read data register full

; vi:ft=asm
