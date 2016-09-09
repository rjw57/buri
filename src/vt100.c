#include <io.h>
#include <vt100.h>

void initscr() {
	puts("\033c");
}

void cls() {
	puts("\033[2J\033[H");
}
