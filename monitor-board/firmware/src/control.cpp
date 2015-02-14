#include "control.h"

#include <Arduino.h>

#include "globals.h"
#include "pins.h"

void writeControlLines() {
    // Update control lines
    digitalWrite(HALT, halt_request ? HIGH : LOW);

    // This cycle vs step logic is confusing and buggy. Re-think it.

    // step only makes sense if processor halted
    if(cycle_request || (skip_to_next_sync && !(status_bits & SB_SYNC))) {
        // Pulse step pin
        digitalWrite(STEP, HIGH);
        digitalWrite(STEP, LOW);

        // If we are skipping rather than cycling, reset skip
        if(!cycle_request) {
            skip_to_next_sync = false;
        } else {
            // Reset cycle request
            cycle_request = false;
        }
    }
}

void readBus() {
    // Stop loading data into shift reg. From Data sheet: the LOW-to-HIGH
    // transition of input CE should only take place while CP HIGH for
    // predictable operation.
    digitalWrite(SCLK, HIGH);
    digitalWrite(BUS_PLBAR, HIGH);

    // Read from bus shift reg
    status_bits = shiftIn(MISO, SCLK, MSBFIRST);
    data_bus = shiftIn(MISO, SCLK, MSBFIRST);
    address_bus =
        (static_cast<unsigned int>(shiftIn(MISO, SCLK, MSBFIRST)) << 8) |
        static_cast<unsigned int>(shiftIn(MISO, SCLK, MSBFIRST));

    // Resume loading data into shift reg.
    digitalWrite(BUS_PLBAR, LOW);
}
