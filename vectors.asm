; Imported symbols
.import _reset

; Write code into ROM code segment
.segment "ROCODE"

; Interrupt handler
handle_irq:
	rti		; Return from handler

; NMI handler
handle_nmi:
	rti		; Return from handler

; Processor interrupt and reset vector table
.segment "VECTORS"
.word handle_irq, _reset, handle_nmi
