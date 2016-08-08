;
; Processor reset and interrupt vector table.
;

; Import the non-NOP vecto handlers
.import vector_reset
.import irq_head
.import nmi_head
.import brk_head

; A "NOP" vector which does nothing except return.
.proc nop_handler
	rti
.endproc

; The 65816 has two separate vector tables, one for "emulation" mode and one for
; "native" mode. Since we're a native-only OS, the emulation mode vectors are
; all NOPs (apart from the reset vector). In native mode we support only irq,
; nmi and brk. Each of these end up being 

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
