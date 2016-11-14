#include "hw/vdp.h"

static const char msg[] = "Buri Microcomputer System";

static void puts(const char* s) {
	for(; *s != '\0'; ++s) {
		vdp_write_char(*s);
	}
}

void start(void) {
	vdp_init();
	puts(msg);
	while(1) { }
}
