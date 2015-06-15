;
; Global variables used by OS.
;

;; CONSTANTS

; The number of bytes dedicated to storing a line of input from the keyboard.
LINE_BUFFER_SIZE = $80

;; ZERO PAGE

; Temporary pointers - not guaranteed to be preserved over function call
.globalzp ptr1
.globalzp ptr2
.globalzp ptr3

; Temporary variables - not guaranteed to be preserved over function call
.globalzp tmp1
.globalzp tmp2
.globalzp tmp3

; Offsets into line_buffer of CLI command name an arguments. Note that since
; line_buffer is entirely within the private page, it is guranteed that
; line_buffer+{cmdname,arg{1,2,3}} does not overflow the low byte.
.globalzp cmdname
.globalzp arg1
.globalzp arg2
.globalzp arg3

; Cache of ACIA status register copied when there's an interrupt.
.globalzp acia_sr

;; OS PRIVATE PAGE

; Command input buffer
.global line_buffer

; vi:ft=asm

