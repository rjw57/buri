// Firmware for monitor board

#include "io.h"
#include "mx7219.h"
#include "pins.h"

int loop_counter = 0;

// 16-bit address bus value
unsigned int address_bus;

// 8-bit data bus value
byte data_bus;

void setup() {
    // Setup all pin modes
    pinMode(MISO, OUTPUT);  // NB: (1)
    pinMode(MOSI, INPUT);   // NB: (1)
    pinMode(SCLK, OUTPUT);
    pinMode(DLOAD, OUTPUT);

    // Initial pin values
    digitalWrite(SCLK, LOW);
    digitalWrite(MISO, LOW);
    digitalWrite(DLOAD, LOW);

    // Initial address/data bus values
    address_bus = data_bus = 0;

    // Set up MX7219
    setupMX7219();

    // Reset loop counter
    loop_counter = 0;
}

void loop() {
    // Update address bus
    setMX7219Reg(MX7219_DIGIT_0 + 0, MX7219_FONT[address_bus & 0xF]);
    setMX7219Reg(MX7219_DIGIT_0 + 1, MX7219_FONT[(address_bus>>4) & 0xF]);
    setMX7219Reg(MX7219_DIGIT_0 + 2, MX7219_FONT[(address_bus>>8) & 0xF]);
    setMX7219Reg(MX7219_DIGIT_0 + 3, MX7219_FONT[(address_bus>>12) & 0xF]);

    // Update data bus
    setMX7219Reg(MX7219_DIGIT_0 + 4, MX7219_FONT[data_bus & 0xF]);
    setMX7219Reg(MX7219_DIGIT_0 + 5, MX7219_FONT[(data_bus>>4) & 0xF]);

    delay(300);
    address_bus += 1;
    data_bus -= 1;
}

// vim:filetype=c
