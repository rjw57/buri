#include "util.h"
#include "../io.h"

void put_hex_4(u8 val) {
    putc(val < 10 ? val + '0' : val + 'A' - 10);
}

void put_hex_8(u8 val) {
    put_hex_4(val>>4);
    put_hex_4(val&0xf);
}

void put_hex_16(u16 val) {
    put_hex_8(val>>8);
    put_hex_8(val&0xff);
}

void put_hex_24(u32 val) {
    put_hex_8((val>>8)&0xff);
    put_hex_8((val>>8)&0xff);
    put_hex_8(val&0xff);
}

// return non zero if strings a and b are equal
int streq(char *a, char *b) {
    int i=0;
    for(; (a[i] != '\0') && (b[i] != '\0'); ++i) {
        if(a[i] != b[i]) { return 0; }
    }

    // check terminator
    if(a[i] != b[i]) { return 0; }

    return 1;
}

