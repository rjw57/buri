#include <io.h>
#include "cmd.h"

void cmd_echo(void) {
	puts("1:");
	putln(line_buffer + arg1);
	puts("2:");
	putln(line_buffer + arg2);
	puts("3:");
	putln(line_buffer + arg3);
}
