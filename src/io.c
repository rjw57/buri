#include <io.h>

void puts(char* s) {
	char c;
	while(c = s[0]) {
		putc(c);
		++s;
	}
}

void putln(char* s) {
	puts(s);
	putc('\n');
}
