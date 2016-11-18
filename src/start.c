#include "console.h"
#include "cli.h"

static const char msg[] = "Buri Microcomputer System";

void __cdecl__ putc(u8 c) { console_write_char(c); }

static void puts(const char* s) {
    for(; *s != '\0'; ++s) { putc(*s); }
}

static void putln(const char* s) {
    puts(s);
    putc(0x0A);
    putc(0x0D);
}

static void put_hex_4(u8 val) {
    putc(val < 10 ? val + '0' : val + 'A' - 10);
}

static void put_hex_8(u8 val) {
    put_hex_4(val>>4);
    put_hex_4(val&0xf);
}

static void put_hex_16(u16 val) {
    put_hex_8(val>>8);
    put_hex_8(val&0xff);
}

static u8 parse_hex_4(char c) {
    if((c >= '0') && (c <= '9')) { return c - '0'; }
    if((c >= 'a') && (c <= 'f')) { return c - ('a' - 10); }
    if((c >= 'A') && (c <= 'F')) { return c - ('A' - 10); }
    return 0;
}

static u16 parse_hex_16(const char* s) {
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

void process_cli(void) {
    if(streq(cli_buf, "help")) {
        putln("You need somebody");
    } else if(streq(cli_buf, "dump")) {
        dump();
    }
}

void start(void) {
    int i = 0;
    i16 v = 0;

    console_init();

    putln(msg);
    putln("");

    cli_start(putc);
    while(1) {
        console_idle();
        v = console_read_char();
        if(v < 0) { continue; }
        if(cli_new_char((u8)v)) {
            process_cli();
            cli_start(putc);
        }
    }
}

