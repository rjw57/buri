#include "console.h"

static const char msg[] = "Buri Microcomputer System";

static void puts(const char* s) {
    for(; *s != '\0'; ++s) {
        console_write_char(*s);
    }
}

static void put_hex_nibble(u8 val) {
    console_write_char(val < 10 ? val + '0' : val + 'A' - 10);
}

static void put_hex_byte(u8 val) {
    put_hex_nibble(val>>4);
    put_hex_nibble(val&0xf);
}

i16 keyboard_get_next_scancode(void);

void start(void) {
    console_init();
    puts(msg);
    console_write_char(' ');

    while(1) {
        i16 v = console_read_char();
        if(v < 0) { continue; }

        if((u8)v >= 0x20) {
            console_write_char(v);
        } else {
            console_write_char('<');
            put_hex_byte(v);
            console_write_char('>');
        }
    }
}

