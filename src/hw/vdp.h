/* Driver for Video Display Processor */
#include "types.h"

/* Initialise VDP hardware */
void vdp_init(void);

/* Write to the VDP ctrl register */
void vdp_write_ctrl(u8 value);

/* Write to the VDP data register */
void vdp_write_data(u8 value);

/* Read from the VDP data register */
u8 vdp_read_data(void);
