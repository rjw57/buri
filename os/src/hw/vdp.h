/* Driver for Video Display Processor */
#include "types.h"

/* Initialise VDP hardware */
void vdp_init(void);

/* Set VRAM write address */
void vdp_set_write_addr(u16 addr);

/* Set VRAM read address */
void vdp_set_read_addr(u16 addr);
