// Firmware for monitor board

#include "io.h"
#include "mx7219.h"
#include "pins.h"

int loop_counter = 0;

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

    // Set up MX7219
    setupMX7219();

    // Reset loop counter
    loop_counter = 0;
}

void loop() {
    for(int digit=0; digit<6; ++digit) {
        int fontCode = (loop_counter + digit) % MX7219_FONT_N_CHARS;
        setMX7219Reg(MX7219_DIGIT_0 + (5-digit), MX7219_FONT[fontCode]);
    }

    delay(250);
    loop_counter += 1;
}

// vim:filetype=c
