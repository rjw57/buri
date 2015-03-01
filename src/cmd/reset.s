.include "macros.inc"

registercmd "reset", entry

; reset - soft-reset the computer
.proc entry
	jmp ($FFFC)			; jump to reset vector
.endproc
