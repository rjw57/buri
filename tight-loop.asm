.segment "ROCODE"

; ROM entry point
reset:
	JMP reset

; Interrupt handler
irq:
	RTI		; Exit interrupt handler

; Non-maskable interrupt handler
nmi:
	RTI		; Exit interrupt handler

; OS entry vectors
.segment "VECTORS"
.word	irq, reset, nmi
