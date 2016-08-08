;
; Processor reset and interrupt vector table.
;

; Import the non-NOP vecto handlers
.import vector_reset
.import vector_irq
.import vector_nmi
.import vector_brk

; A "NOP" vector which does nothing except return.
.proc vector_nop
	rti
.endproc

; The 65816 has two separate vector tables, one for "emulation" mode and one for
; "native" mode. Since we're a native-only OS, the emulation mode vectors are
; all NOPs (apart from the reset vector). In native mode we support only irq,
; nmi and brk. Each of these end up being 

.segment "VECTORS"
.word vector_nop ; cop
.word vector_brk
.word vector_nop ; abort
.word vector_nmi
.word vector_nop
.word vector_irq

.segment "VECTORS_E"
.word vector_nop
.word vector_nop
.word vector_nop
.word vector_nop
.word vector_reset
.word vector_nop
