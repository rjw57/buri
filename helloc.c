#include <conio.h>

void puts(const char* s) {
	for(; *s!='\0'; ++s) {
		cputc(*s);
	}
}

int main() {
	puts("Hello, world\r\n");
	return 0;
}
