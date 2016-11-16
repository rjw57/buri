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

int keyboard_get_next_scancode(void);

void start(void) {
    console_init();
    puts(msg);
    console_write_char(' ');

    while(1) {
        int v = keyboard_get_next_scancode();
        if(v >= 0) {
            put_hex_byte(v);
            console_write_char(' ');
        }
    }
}

