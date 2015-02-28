.include "macros.inc"

; dump <addr> <len>
;
; Dumps to screen <len> bytes from memory starting at <addr>. Both <len> and
; <addr> are hexadecimal.
;
; on entry:
; 	arg{1,2,3} - offsets into line_buffer of arguments 1, 2 and 3
;
entry:
	; TODO
	rts

; record command in command table
registercmd "dump", entry
