;
; Global symbols used by OS.
;

;; Macros

; Encode a string as it's length and then it's contents. (Pascal-style)
.macro PString Str
	.byte	.strlen(Str), Str
.endmacro

;; Well-known I/O devices
ACIA1 = $8000
ACIA1_DATA 	= ACIA1
ACIA1_STATUS 	= ACIA1 + 1
ACIA1_CMD 	= ACIA1 + 2
ACIA1_CTRL 	= ACIA1 + 3

;; Constants
ACIA_ST_TRDE = %00010000	; status: transmit data register empty

;; Zero page globals

; Temporary-use pointers and variables.
; These need not be preserved across function calls.
.globalzp ptr1
.globalzp ptr2
.globalzp tmp1
.globalzp tmp2
.globalzp tmp3

; Copy of ACIA1 status reg
.globalzp acia1_status_cache
