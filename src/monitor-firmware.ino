// Firmware for monitor board

// Pin definitions
#define MISO    2   // NB: (1)
#define MOSI    3   // NB: (1)
#define SCLK    4
#define DLOAD   8

// (1) Since the monitor board is a slave device w.r.t. the processor board,
// MISO is an OUTPUT and MOSI is an INPUT.
#include "mx7219.h"

// Directions to use with sendAndReceive.
#define LSB_FIRST 0
#define MSB_FIRST 1

// Send a byte along the MISO line. Return the bye which was simultaneously
// received over the MOSI line. If direction is LSB_FIRST then the data is sent
// LSB first, otherwise the data is sent MSB first.
byte sendAndReceive(byte output, int direction);

// Set MX7219 register to a given value.
void setMX7219Reg(byte reg, byte value) {
    // Shift reg then byte since MX7219 expects data in MSB order.
    digitalWrite(DLOAD, LOW);
    sendAndReceive(reg, MSB_FIRST);
    sendAndReceive(value, MSB_FIRST);

    // Pulse DLOAD
    digitalWrite(DLOAD, HIGH);
    digitalWrite(DLOAD, LOW);
}

byte sendAndReceive(byte output, int direction) {
    byte input = 0;

    // For each bit...
    for(int bit_idx=0; bit_idx<8; ++bit_idx) {
        int actual_idx = (direction == LSB_FIRST) ? bit_idx : (7-bit_idx);
        int bit = (output >> actual_idx) & 0x1;

        // Set bit
        digitalWrite(MISO, bit ? HIGH : LOW);

        // Toggle clock
        digitalWrite(SCLK, HIGH);
        digitalWrite(SCLK, LOW);

        // Read input
        if(digitalRead(MOSI) == HIGH) {
            input |= (1 << actual_idx);
        }
    }

    return input;
}

int loop_counter = 0;

void setup() {
    // Setup all pin modes
    pinMode(MISO, OUTPUT);  // NB: (1)
    pinMode(MOSI, INPUT);   // NB: (1)
    pinMode(SCLK, OUTPUT);
    pinMode(DLOAD, OUTPUT);

    digitalWrite(SCLK, LOW);
    digitalWrite(MISO, LOW);
    digitalWrite(DLOAD, LOW);

    // Set up MX7219
    setMX7219Reg(MX7219_DECODE_MODE, 0x00); // No decode
    setMX7219Reg(MX7219_INTENSITY, 0xFF);   // Maximum intensity
    setMX7219Reg(MX7219_SCN_LIMIT, 0x05);   // Scan digits 0-5
    setMX7219Reg(MX7219_DPLY_TEST, 0x00);   // No display test
    setMX7219Reg(MX7219_SHUTDOWN, 0x01);    // Normal operation

    // Reset loop counter
    loop_counter = 0;
}

void loop() {
    for(int digit=0; digit<6; ++digit) {
        int fontCode = (loop_counter + digit) % MX7219_FONT_N_CHARS;
        setMX7219Reg(MX7219_DIGIT_0 + (5-digit), MX7219_FONT[fontCode]);
    }

    delay(500);
    loop_counter += 1;
}

// vim:filetype=c
