#ifndef ACIA6551_H
#define ACIA6551_H

#include "types.h"

void acia6551_init(void);
u8 acia6551_send_byte(u8);
i16 acia6551_recv_byte(void);

#endif
