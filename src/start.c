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
    int i=0;
    console_init();

    do {
        puts(msg);
        console_write_char(' ');
    } while(0);
    console_write_char(0x0A);
    console_write_char(0x0D);

    while(1) {
        i16 v = console_read_char();
        console_idle();

        if(v < 0) { continue; }

        if((u8)v >= 0x20) {
            console_write_char(v);
        } else if((u8)v == 0x08) {
            // Backspace
            console_write_char(0x08);
            console_write_char(' ');
            console_write_char(0x08);
        } else if((u8)v == 0x0D) {
            // Enter
            console_write_char(0x0A);
            console_write_char(0x0D);
        } else {
            console_write_char('<');
            put_hex_byte(v);
            console_write_char('>');
        }
    }
}

