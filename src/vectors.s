; Hardware vector table.
;
; The 65816 has two hardware vector tables. One is active in "emulation" mode
; and one in "native". This file defines the contents of both.

; Import the non-NOP handlers
.import vector_reset
.import irq_head
.import nmi_head
.import brk_head

; A "NOP" handler which does nothing except return.
.proc nop_handler
	rti
.endproc

; Since we're a "native" OS, the emulation mode vectors are all NOPs (apart from
; the reset vector).

.segment "VECTORS"
.word nop_handler ; cop
.word brk_head
.word nop_handler ; abort
.word nmi_head
.word nop_handler
.word irq_head

.segment "VECTORS_E"
.word nop_handler
.word nop_handler
.word nop_handler
.word nop_handler
.word vector_reset
.word nop_handler
