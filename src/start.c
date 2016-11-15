#include "console.h"

static const char msg[] = "Buri Microcomputer System";

static void puts(const char* s) {
    for(; *s != '\0'; ++s) {
        console_write_char(*s);
    }
}

void start(void) {
    console_init();
    while(1) {
        int i=0;
        puts(msg); puts(" ");
    }
}

