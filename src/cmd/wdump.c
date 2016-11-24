#include "commands.h"
#include "../util.h"
#include "../cli.h"
#include "../io.h"

void wdump(void) {
    u8 buffer[16];
    u8 i;
    u16 start = parse_hex_16(cli_buf + cli_arg_offsets[0]);
    u16 len = parse_hex_16(cli_buf + cli_arg_offsets[1]);
    u16 end, addr, out_count;

    if((cli_buf + cli_arg_offsets[1])[0] == '\0') { len = 0x100; }

    end = start + len;
    for(out_count = 0, addr = start; addr != end; ++addr, ++out_count) {
        u8 val = ((u8*)addr)[0];
        buffer[out_count & 0xF] = val;

        if((out_count & 0xf) == 0) {
            put_hex_16(addr);
            putc(' ');
            putc(' ');
        }

        if((addr != end-1) && ((out_count & 0xF) != 0xF)) { continue; }

        for(i=0; i<=(out_count&0xF); ++i) {
            put_hex_8(buffer[i]); putc(' ');
            if((i & 0x7) == 7) { putc(' '); }
        }
        putc('|');
        for(i=0; i<=(out_count&0xF); ++i) {
            val = buffer[i];
            putc(((val >= 0x20) && (val < 0x7F)) ? val : '.');
        }
        putln("|");
    }
}

