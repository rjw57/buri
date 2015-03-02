; OS entry point jump table

.import putc
.import getc
.import haveinput

.segment "JMPTBL"
	jmp putc
	jmp getc
	jmp haveinput
