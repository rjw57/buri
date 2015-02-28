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

; Temporary variables - not guaranteed to be preserved over function call
.globalzp tmp1
.globalzp tmp2
.globalzp tmp3

;; OS PRIVATE PAGE

; Command input buffer
.global line_buffer

; vi:ft=asm

