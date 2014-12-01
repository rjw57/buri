; Imported symbols
.import reset
.import irq
.import nmi

; Processor interrupt and reset vector table
.segment "VECTORS"
.word irq, reset, nmi
