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

    console_cursor_set(3, 5);
    console_write_char('X');
    console_cursor_set(0, 0);
    console_write_char('O');
    console_cursor_set(10, 2);
    console_write_char('/');
    console_cursor_set(39, 2);
    console_write_char('>');
    console_cursor_set(38, 2);
    console_write_char('A');

    while(1) { puts(msg); puts(" "); }
}
