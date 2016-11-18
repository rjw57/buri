#include "types.h"

#define SPI_MODE0 0x00
#define SPI_MODE1 0x40
#define SPI_MODE2 0x80
#define SPI_MODE3 0xC0

#define SPI_MSB_FIRST 0x20
#define SPI_LSB_FIRST 0x00

#define SPI_DEVICE_0 0x00
#define SPI_DEVICE_1 0x01
#define SPI_DEVICE_2 0x02
#define SPI_DEVICE_3 0x03
#define SPI_DEVICE_4 0x04
#define SPI_DEVICE_5 0x05
#define SPI_DEVICE_6 0x06

void spi_init(void);
void spi_begin(u8 mode_and_device);
void spi_end(void);
u8 spi_exchange(u8 value);
