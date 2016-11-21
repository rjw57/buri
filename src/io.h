// I/O routines
#ifndef IO_H
#define IO_H

#include "types.h"

#define IO_INPUT_CONSOLE    0x01
#define IO_INPUT_SERIAL     0x02
#define IO_OUTPUT_CONSOLE   0x04
#define IO_OUTPUT_SERIAL    0x08

extern u8 io_mask;

void putc(u8 c);
i16 getc(void);
void puts(const char* s);
void putln(const char* s);

#endif
