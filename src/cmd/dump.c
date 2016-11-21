#include "util.h"
#include "commands.h"
#include "../cli.h"
#include "../io.h"

void dump(void) {
    u16 start = parse_hex_16(cli_buf + cli_arg_offsets[0]);
    u16 len = parse_hex_16(cli_buf + cli_arg_offsets[1]);
    u16 end, addr, out_count;

    if((cli_buf + cli_arg_offsets[1])[0] == '\0') { len = 0x100; }

    end = start + len;
    for(out_count = 0, addr = start; addr != end; ++addr, ++out_count) {
        u8 val = ((u8*)addr)[0];

        if((out_count & 0xf) == 0) {
            put_hex_16(addr);
            putc(' ');
            putc(' ');
        }

        put_hex_8(val);

        if((out_count & 0xf) == 0xf) {
            putc(0x0a); putc(0x0d);
        } else if((out_count & 0x7) == 0x7) {
            putc(' ');
        }
    }
}

