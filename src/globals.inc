;
; Global symbols used by OS.
;

;; Constants

ASCII_BS = $08				; ASCII backspace
ASCII_NL = $0A				; ASCII newline
ASCII_CR = $0D				; ASCII carriage return

MAX_LINE = $80				; maximum input line length

SRL_BUF_MAG = 1				; log2(SRL_BUF_SZ)
SRL_BUF_SZ = 1<<SRL_BUF_MAG		; #bytes capacity of serial buffer
SRL_BUF_MASK = SRL_BUF_SZ-1		; mask for rounding value into buffer len

;; Macros

; Encode a string as it's length and then it's contents. (Pascal-style)
.macro PString Str
	.byte	.strlen(Str), Str
.endmacro

; Temporary-use pointers and variables.
; These need not be preserved across function calls.
.globalzp ptr1
.globalzp ptr2
.globalzp tmp1
.globalzp tmp2
.globalzp tmp3

.globalzp line_len
.globalzp srl_buf_len
.globalzp srl_buf_start
.globalzp acia1_recv_data

.global srl_buffer

.global line_buffer
