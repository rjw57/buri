;
; Global symbols used by OS.
;

;; Macros

; Encode a string as it's length and then it's contents. (Pascal-style)
.macro PString Str
	.byte	.strlen(Str), Str
.endmacro

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

; Last received byte on ACIA1
.globalzp acia1_recv_data
