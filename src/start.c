#include "hw/vdp.h"
#include "console.h"

static const char msg[] = "Buri Microcomputer System";

static void puts(const char* s) {
    for(; *s != '\0'; ++s) {
        console_write_char(*s);
    }
}

void start(void) {
    vdp_init();
    console_init();
    while(1) { puts(msg); puts(" "); }
}
