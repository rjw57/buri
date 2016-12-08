#include "io.h"

#include "hw/acia6551.h"
#include "hw/keyboard.h"
#include "console.h"

u8 io_mask;

void putc(u8 c) {
    if(io_mask & IO_OUTPUT_SERIAL) {
        while(!acia6551_send_byte(c)) { }
    }

    if(io_mask & IO_OUTPUT_CONSOLE) {
        console_write_char(c);
    }
}

i16 getc(void) {
    i16 v;
    if(io_mask & IO_INPUT_CONSOLE) {
        v = keyboard_read_ascii();
        if(v >= 0) { return v; }
    }
    if(io_mask & IO_INPUT_SERIAL) {
        v = acia6551_recv_byte();
        if(v >= 0) { return v; }
    }
    return -1;
}

void puts(const char* s) {
    for(; *s != '\0'; ++s) { putc(*s); }
}

void putln(const char* s) {
    puts(s);
    putc(0x0A);
    putc(0x0D);
}

