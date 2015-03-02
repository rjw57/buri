// Print Fibbonaci numbers up to ~4 billion

#include <conio.h>

void puts(const char* s) {
	for(; *s!='\0'; ++s) {
		cputc(*s);
	}
}

int main() {
	unsigned long a, b, next;
	a = b = 1;
	cprintf("%lu %lu ", a, b);
	do {
		next = a + b;
		cprintf("%lu ", next);
		a = b; b = next;
	} while(next < 4000000000ul);
	cputc('\r');
	cputc('\n');
	return 0;
}
