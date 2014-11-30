.segment "ROCODE"

; ROM entry point
reset:
	JMP reset

.include "inc/interrupt_handlers.asm"
.include "inc/vectors.asm"
