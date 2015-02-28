;
; Global variables used by OS.
;

;; CONSTANTS

; The number of bytes dedicated to storing a line of input from the keyboard.
LINE_BUFFER_SIZE = $80

;; ZERO PAGE

; Temporary pointers - preserved over function call
.globalzp ptr1

; Temporary variables - preserved over function call
.globalzp tmp1

; Number of bytes in input biffer
.globalzp line_len

;; OS PRIVATE PAGE

; Command input buffer
.global line_buffer

; vi:ft=asm

