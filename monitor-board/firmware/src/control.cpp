#include "control.h"

#include <Arduino.h>

#include "globals.h"
#include "pins.h"
#include "mx7219.h"

static void writeControlLines();
static void readBus();

void controlSetup() {
    pinMode(PIN_STEP, OUTPUT);
    pinMode(PIN_HALT, OUTPUT);
    pinMode(PIN_ILOADBAR, OUTPUT);

    pinMode(PIN_RCLK, OUTPUT);

    // We write and *then* set the mode in order to first enable the internal
    // pullup and then set the pin as an output thereby avoiding pulling the
    // pin *down* on startup. The second digitalWrite() is to guard ourselves
    // since nothing in the Arduino documentation says anything about the state
    // of the pins after resetting pinMode().
    digitalWrite(PIN_DTAOEBAR, HIGH);
    pinMode(PIN_DTAOEBAR, OUTPUT);
    digitalWrite(PIN_DTAOEBAR, HIGH);
    digitalWrite(PIN_ADROEBAR, HIGH);
    pinMode(PIN_ADROEBAR, OUTPUT);
    digitalWrite(PIN_ADROEBAR, HIGH);

    // Don't load internal shift reg to outputs in output stage.
    digitalWrite(PIN_RCLK, LOW);

    // Initial address/data bus values
    address_bus = data_bus = 0;

    // Initially all status bits are off
    status_bits = 0;

    // Processor is in running state
    halt = false;
    step_state = SS_NONE;

    // Set bus shift registers to load
    digitalWrite(PIN_ILOADBAR, LOW);
}

void controlLoop() {
    readBus();
    writeControlLines();
}

bool processorRunning() {
    byte msk = SB_RDY | SB_RSTBAR | SB_BE;
    return (status_bits & msk) == msk;
}

bool processorCanBeStepped() {
    byte msk = SB_RSTBAR | SB_BE;
    return !(status_bits & SB_RDY) && ((status_bits & msk) == msk);
}

static void writeControlLines() {
    // Update control lines
    digitalWrite(PIN_HALT, halt ? HIGH : LOW);

    if(pull_rst_low) {
        pinMode(PIN_RSTBAR, OUTPUT);
        digitalWrite(PIN_RSTBAR, LOW);
    } else {
        pinMode(PIN_RSTBAR, INPUT);
    }

    if(pull_be_low) {
        pinMode(PIN_BE, OUTPUT);
        digitalWrite(PIN_BE, LOW);
    } else {
        pinMode(PIN_BE, INPUT);
    }

    // Set appropriate values reflecting assertion of address/data buses.
    digitalWrite(PIN_DTAOEBAR, assert_data ? LOW : HIGH);
    digitalWrite(PIN_ADROEBAR, assert_address ? LOW : HIGH);

    // If we're asserting address or data bus, shift values into register.
    if(assert_address || assert_data) {
        shiftOut(MOSI, SCLK, MSBFIRST, out_data_bus);
        shiftOut(MOSI, SCLK, MSBFIRST, (out_address_bus >> 8) & 0xFF);
        shiftOut(MOSI, SCLK, MSBFIRST, out_address_bus & 0xFF);

        // load new value into shift-reg output
        digitalWrite(PIN_RCLK, HIGH);
        digitalWrite(PIN_RCLK, LOW);
    }

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
            digitalWrite(PIN_STEP, HIGH);
            digitalWrite(PIN_STEP, LOW);
        }
    }
}

static void readBus() {
    // Stop loading data into shift reg. From Data sheet: the LOW-to-HIGH
    // transition of input CE should only take place while CP HIGH for
    // predictable operation.
    digitalWrite(SCLK, HIGH);
    digitalWrite(PIN_ILOADBAR, HIGH);

    // Read from bus shift reg
    status_bits = shiftIn(MISO, SCLK, MSBFIRST);
    data_bus = shiftIn(MISO, SCLK, MSBFIRST);
    address_bus =
        (static_cast<unsigned int>(shiftIn(MISO, SCLK, MSBFIRST)) << 8) |
        static_cast<unsigned int>(shiftIn(MISO, SCLK, MSBFIRST));

    // Resume loading data into shift reg.
    digitalWrite(PIN_ILOADBAR, LOW);
}
