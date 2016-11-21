#include "cli.h"
#include "io.h"

char cli_buf[CLI_BUF_LEN];
u8 cli_arg_offsets[CLI_MAX_ARGS];
static u8 cli_buf_size;

void cli_write_prompt(void) {
    putc('>');
}

void cli_start(void) {
    cli_buf[0] = '\0';
    cli_buf_size = 0;
    cli_write_prompt();
}

// Returns non zero if command complete
u8 cli_new_char(u8 c) {
    if(c == 0x0D) {
        u8 i = 0, arg_n = 0;

        // enter
        putc(0x0A);
        putc(0x0D);
        cli_buf[cli_buf_size] = '\0';
        for(; i<cli_buf_size; ++i) {
            if(cli_buf[i] == ' ') {
                cli_buf[i] = '\0';
                if(arg_n < CLI_MAX_ARGS) { cli_arg_offsets[arg_n] = i+1; }
                ++arg_n;
            }
        }
        // remaining arguments point to terminating '\0'.
        for(; arg_n<CLI_MAX_ARGS; ++arg_n) {
            cli_arg_offsets[arg_n] = cli_buf_size;
        }
        cli_buf_size = 0;
        return 1;
    }

    // Backspace
    if((c == 0x08) || (c == 0x7F)) {
        if(cli_buf_size > 0) {
            putc(0x08);
            putc(' ');
            putc(0x08);
            --cli_buf_size;
        }
        return 0;
    }

    // cmd buf full
    if(cli_buf_size == CLI_BUF_LEN-1) { return 0; }

    // unprintable
    if(c < 0x20) { return 0; }

    cli_buf[cli_buf_size] = c;
    ++cli_buf_size;
    putc(c);

    return 0;
}

