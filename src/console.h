#include "types.h"

void console_init(void);
void console_cursor_set(u8 col, u8 row);
void console_write_char(u8 c);
i16 console_read_char(void);
