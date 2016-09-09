#include <io.h>
#include <common.h>
#include "cmd.h"

void putnibble(char v) {
	if(v<10) { putc('0' + v); return; }
	if(v<16) { putc('A' - 10 + v); return; }
badnibble:
	putc('?');
}

void puthexbyte(char b) {
	putnibble(b>>4);
	putnibble(b&0xF);
}

void puthexint(int v) {
	puthexbyte(v>>8);
	puthexbyte(v&0xFF);
}

void cmd_dump(void) {
	char* start = 0;
	int len = 0;
	int idx = 0;

	start = parsehex16(line_buffer + arg1);
	len = parsehex16(line_buffer + arg2);
	if(len == 0) { len = 0x100; }

	for(;len>0;--len,++idx,++start) {
		if((idx & 0xF) == 0x0) {
			puthexint((int)start);
			putc(' ');
			putc(' ');
		}
		puthexbyte(start[0]);
		putc(' ');
		if((idx & 0xF) == 0xF) {
			putc('\n');
		} else if((idx & 0x7) == 0x7) {
			putc(' ');
		}
	}
}

