; Hardware vector table.
;
; The 65816 has two hardware vector tables. One is active in "emulation" mode
; and one in "native". This file defines the contents of both.

; A "NOP" handler which does nothing except return.
.proc nop_handler
	rti
.endproc

; Native mode vectors

.segment "VECTORS"
.word nop_handler	; (reserved)
.word nop_handler	; (reserved)
.word nop_handler	; COP
.word nop_handler	; BRK
.word nop_handler	; ABORT
.word nop_handler	; NMI
.word nop_handler	; (reserved)
.word nop_handler	; IRQ

; Emulated mode vectors.

.segment "VECTORS_E"
.import vector_reset

.word nop_handler	; (reserved)
.word nop_handler	; (reserved)
.word nop_handler	; COP
.word nop_handler	; (reserved)
.word nop_handler	; ABORT
.word nop_handler	; NMI
.word vector_reset	; RESET
.word nop_handler	; IRQ/BRK
