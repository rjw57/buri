#include "Arduino.h"
#include "io.h"
#include "pins.h"

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

