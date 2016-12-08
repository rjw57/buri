#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "types.h"

void keyboard_init(void);
i16 keyboard_read_next_scancode(void);
i16 keyboard_read_ascii(void);

#endif
