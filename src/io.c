#include "io.h"

#include "hw/acia6551.h"
#include "hw/keyboard.h"
#include "console.h"

void putc(u8 c) {
    while(!acia6551_send_byte(c)) { }
    console_write_char(c);
}

i16 getc(void) {
    i16 v = keyboard_read_ascii();
    if(v >= 0) { return v; }
    return acia6551_recv_byte();
}

void puts(const char* s) {
    for(; *s != '\0'; ++s) { putc(*s); }
}

void putln(const char* s) {
    puts(s);
    putc(0x0A);
    putc(0x0D);
}

