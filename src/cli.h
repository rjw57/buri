#ifndef CLI_H
#define CLI_H

#include "types.h"

#define CLI_BUF_LEN 0x80
#define CLI_MAX_ARGS 3

extern char cli_buf[CLI_BUF_LEN];
extern u8 cli_arg_offsets[CLI_MAX_ARGS];

// CC65 doesn't allow pointers to fastcall functions :(.
typedef void (__cdecl__ *cli_write_char_func_t) (u8);

void cli_start(cli_write_char_func_t write_func);

// Returns non zero if command complete
u8 cli_new_char(u8 c);

#endif
