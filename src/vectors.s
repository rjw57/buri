;
; Processor reset and interrupt vector table.
;

.import reset
.import handle_irq
.import handle_nmi

.segment "VECTORS"
.word handle_irq
.word reset
.word handle_nmi
