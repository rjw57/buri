#include "control.h"

#include <Arduino.h>

#include "globals.h"
#include "pins.h"

static void writeControlLines();
static void readBus();

void controlLoop() {
    readBus();
    writeControlLines();
}

static void writeControlLines() {
    // Update control lines
    digitalWrite(HALT, halt ? HIGH : LOW);

    // If processor halted...
    if(!(status_bits & SB_RDY)) {
        // Is some form of stepping required?
        bool should_step = false;

        switch(step_state) {
            case SS_CYCLE:
                // Pulsing the STEP pin suffices
                should_step = true;
                step_state = SS_NONE;
                break;
            case SS_INST:
                // Pulse STEP but wait for the SYNC
                should_step = true;
                step_state = SS_INST_WAITING_FOR_SYNC;
                break;
            case SS_INST_WAITING_FOR_SYNC:
                // Only step if SYNC is low
                if(status_bits & SB_SYNC) {
                    step_state = SS_NONE;
                } else {
                    should_step = true;
                }
                break;
        }

        if(should_step) {
            // Pulse step pin
            digitalWrite(STEP, HIGH);
            digitalWrite(STEP, LOW);
        }
    }
}

static void readBus() {
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
