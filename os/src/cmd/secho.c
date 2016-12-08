#include "commands.h"
#include "../util.h"
#include "../io.h"
#include "../hw/acia6551.h"

void secho(void) {
    i16 v;
    while(1) {
        while((v = acia6551_recv_byte()) < 0) { }
        if((v >= 0x20l) && (v < 0x7Fl)) {
            putc(v);
        } else {
            putc('<');
            put_hex_8((u8)v);
            putc('>');
        }
    }
}


