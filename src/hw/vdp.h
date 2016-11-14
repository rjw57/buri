/* Driver for Video Display Processor */
#include "types.h"

/* Initialise VDP hardware */
void vdp_init(void);

/* Set VRAM write address */
void vdp_set_write_addr(u16 addr);

/* Set VRAM read address */
void vdp_set_read_addr(u16 addr);

/* Write to the VDP data register */
void vdp_write_data(u8 value);

/* Read from the VDP data register */
u8 vdp_read_data(void);
