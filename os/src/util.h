#ifndef CMD_UTIL_H
#define CMD_UTIL_H

#include "types.h"

void put_hex_4(u8 val);
void put_hex_8(u8 val);
void put_hex_16(u16 val);
void put_hex_24(u32 val);
i16 parse_hex_4(char c);            // -ve on parse error
i16 parse_hex_8(const char* s);     // -ve on parse error
i32 parse_hex_16(const char* s);    // -ve on parse error
i32 parse_hex_24(const char* s);    // -ve on parse error

// return non zero if strings a and b are equal
int streq(char *a, char *b);

#endif
