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

u8 parse_hex_4(char c) {
    if((c >= '0') && (c <= '9')) { return c - '0'; }
    if((c >= 'a') && (c <= 'f')) { return c - ('a' - 10); }
    if((c >= 'A') && (c <= 'F')) { return c - ('A' - 10); }
    return 0;
}

u16 parse_hex_16(const char* s) {
    u8 i=0;
    u16 out=0;
    for(; s[i] != '\0'; ++i) {
        out <<= 4;
        out |= parse_hex_4(s[i]);
    }
    return out;
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

