#include "types.h"

#define SPI_MODE0 0x00
#define SPI_MODE1 0x40
#define SPI_MODE2 0x80
#define SPI_MODE3 0xC0

void spi_init(void);
void spi_begin(u8 mode_and_device);
void spi_end(void);
u8 spi_exchange(u8 value);
