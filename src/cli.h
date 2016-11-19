#ifndef CLI_H
#define CLI_H

#include "types.h"

#define CLI_BUF_LEN 0x80
#define CLI_MAX_ARGS 3

extern char cli_buf[CLI_BUF_LEN];
extern u8 cli_arg_offsets[CLI_MAX_ARGS];

void cli_start(void);

// Returns non zero if command complete
u8 cli_new_char(u8 c);

#endif
