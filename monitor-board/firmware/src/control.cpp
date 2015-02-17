#include "control.h"

#include <Arduino.h>

#include "globals.h"
#include "pins.h"
#include "mx7219.h"

static void writeControlLines();
static void readBus();

// Write addr and data to output shift registers. Make sure to write to
// PIN_DTAOEBAR and/or PIN_ADROEBAR to determine which outputs are asserted.
static void writeBus(unsigned int addr, byte data);

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

    pinMode(PIN_RSTBAR, INPUT);
    pinMode(PIN_BE, INPUT);
    pinMode(PIN_RWBAR, INPUT_PULLUP);

    // Don't load internal shift reg to outputs in output stage.
    digitalWrite(PIN_RCLK, LOW);

    // Don't pull any pins low to begin with.
    pull_rst_low = pull_rwbar_low = pull_be_low = false;

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

    // BE is pulled low when we're asserting an address to make sure that we
    // don't assert an address at the same time as the processor.
    if(pull_be_low || assert_address) {
        pinMode(PIN_BE, OUTPUT);
        digitalWrite(PIN_BE, LOW);
    } else {
        pinMode(PIN_BE, INPUT);
    }

    // R/W~ is not always pulled low when we're asserting the data bus. We
    // might be responding to a read request.
    if(pull_rwbar_low) {
        pinMode(PIN_RWBAR, OUTPUT);
        digitalWrite(PIN_RWBAR, LOW);
    } else {
        pinMode(PIN_RWBAR, INPUT_PULLUP);
    }

    // Set appropriate values reflecting assertion of address/data buses.
    digitalWrite(PIN_DTAOEBAR, assert_data ? LOW : HIGH);
    digitalWrite(PIN_ADROEBAR, assert_address ? LOW : HIGH);

    // If we're asserting address or data bus, shift values into register.
    if(assert_address || assert_data) {
        writeBus(out_address_bus, out_data_bus);
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

static void writeBus(unsigned int addr, byte data) {
    shiftOut(MOSI, SCLK, MSBFIRST, data);
    shiftOut(MOSI, SCLK, MSBFIRST, (addr >> 8) & 0xFF);
    shiftOut(MOSI, SCLK, MSBFIRST, addr & 0xFF);

    // load new value into shift-reg output
    digitalWrite(PIN_RCLK, HIGH);
    digitalWrite(PIN_RCLK, LOW);
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

byte readMem(unsigned int addr) {
    // Take BE low and halt processor
    pinMode(PIN_BE, OUTPUT);
    digitalWrite(PIN_HALT, HIGH);
    digitalWrite(PIN_BE, LOW);

    // Make sure we're reading
    pinMode(PIN_RWBAR, OUTPUT);
    digitalWrite(PIN_RWBAR, HIGH);

    // Assert address
    writeBus(addr, 0);
    digitalWrite(PIN_ADROEBAR, LOW);

    // Wait one millisecond to make sure output is on bus
    delay(1);

    // Read data and address bus
    readBus();

    // Record value
    byte rv = data_bus;

    // Run an iteration of controlLoop() to reset the control lines...
    controlLoop();

    return rv;
}

void writeMem(unsigned int addr, byte value) {
    // Take BE low and halt processor
    pinMode(PIN_BE, OUTPUT);
    digitalWrite(PIN_HALT, HIGH);
    digitalWrite(PIN_BE, LOW);

    // Assert address
    writeBus(addr, value);
    digitalWrite(PIN_ADROEBAR, LOW);

    // Drop R/W~
    pinMode(PIN_RWBAR, OUTPUT);
    digitalWrite(PIN_RWBAR, LOW);

    // Assert data
    digitalWrite(PIN_DTAOEBAR, LOW);

    // Wait for a bit
    delay(1);

    // Raise R/~W
    digitalWrite(PIN_RWBAR, HIGH);

    // Stop asserting data
    digitalWrite(PIN_DTAOEBAR, HIGH);

    // Run an iteration of controlLoop() to reset the control lines...
    controlLoop();
}
