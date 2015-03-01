; OS entry point jump table

.import putc
.import getc

.segment "JMPTBL"
	jmp putc
	jmp getc
