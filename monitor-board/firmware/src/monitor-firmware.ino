// Firmware for monitor board

#include "debounced_switch.h"
#include "control.h"
#include "edge_trigger.h"
#include "globals.h"
#include "mx7219.h"
#include "pins.h"
#include "serialcli.h"
#include "serialstatemachine.h"

// How long to show display test for
const int DPY_TST_DURATION = 500; // milliseconds

DebouncedSwitch mode_switch(BTN_MODE);
DebouncedSwitch select_switch(BTN_SELECT);

EdgeTrigger mode_trigger;
EdgeTrigger select_trigger;

// Poll the switches and update state from them.
void pollSwitches();

// Read any input from the serial device and handle it.
void pollSerial();

// Reflect processor state and address/data bus on LED display. If the
// processor is running (RDY = H) then show the "chasing dots" effect.
void displayProcessorState();

// Initialised in setup().
SerialState serial_state;

void setup() {
    // Setup all pin modes
    pinMode(MOSI, OUTPUT);
    pinMode(MISO, INPUT);
    pinMode(SCLK, OUTPUT);
    pinMode(DLOAD, OUTPUT);
    pinMode(BTN_MODE, INPUT_PULLUP);
    pinMode(BTN_SELECT, INPUT_PULLUP);

    pinMode(STEP, OUTPUT);
    pinMode(HALT, OUTPUT);

    pinMode(BUS_PLBAR, OUTPUT);

    // Start serial port and print banner
    Serial.begin(9600);
    Serial.println("Buri microcomputer system monitor.");
    Serial.println("https://github.com/rjw57/buri-6502-hardware\n");
    serial_state = startSerialPrompt();

    // Set up MX7219 with display test on
    setupMX7219();
    setMX7219Reg(MX7219_SCN_LIMIT, 0x06);   // Scan digits 0-6
    setMX7219Reg(MX7219_DPLY_TEST, 0x01);   // Enable display test
    unsigned long dt_shown_at = millis();   // Record display test time

    // Set bus shift registers to load
    digitalWrite(BUS_PLBAR, LOW);

    // Initial address/data bus values
    address_bus = data_bus = 0;

    // Initially all status bits are off
    status_bits = 0;

    // Processor is in running state
    halt = false;
    step_state = SS_NONE;

    // OK, all done, just wait for display test to time out
    while(millis() - dt_shown_at < DPY_TST_DURATION) {
        // NOP
    }
    setMX7219Reg(MX7219_DPLY_TEST, 0x00);
}

void loop() {
    // Input
    pollSerial();
    pollSwitches();

    // Process input
    controlLoop();

    // Output
    displayProcessorState();
}

void pollSwitches() {
    // Poll switches
    mode_switch.poll();
    select_switch.poll();

    // Update triggers
    mode_trigger.update(mode_switch.state() == HIGH);
    select_trigger.update(select_switch.state() == HIGH);

    // Update flags from switch states
    if(mode_trigger.triggered()) {
        halt = !halt;
    }

    if(select_trigger.triggered()) {
        step_state = SS_CYCLE;
    }

    // Clear mode/select trigger
    mode_trigger.clear();
    select_trigger.clear();
}

void displayProcessorState() {
    // Set status bit LEDs
    setMX7219Reg(MX7219_DIGIT_0 + 6, status_bits);

    if(processorRunning()) {
        // Processor running, show running dots
        int point = (millis() >> 7) % 6;
        for(int digit=0; digit<6; ++digit) {
            setMX7219Reg(MX7219_DIGIT_0 + digit,
                    (point == (5-digit)) ? 0x80 : 0x00);
        }
    } else {
        // Update address bus
        setMX7219Reg(MX7219_DIGIT_0 + 0, MX7219_FONT[address_bus & 0xF]);
        setMX7219Reg(MX7219_DIGIT_0 + 1, MX7219_FONT[(address_bus>>4) & 0xF]);
        setMX7219Reg(MX7219_DIGIT_0 + 2, MX7219_FONT[(address_bus>>8) & 0xF]);
        setMX7219Reg(MX7219_DIGIT_0 + 3, MX7219_FONT[(address_bus>>12) & 0xF]);

        // Update data bus
        setMX7219Reg(MX7219_DIGIT_0 + 4, MX7219_FONT[data_bus & 0xF]);
        setMX7219Reg(MX7219_DIGIT_0 + 5, MX7219_FONT[(data_bus>>4) & 0xF]);
    }
}

void pollSerial() {
    while(Serial.available() > 0) {
        serial_state = serial_state.next(Serial.read());
    }
}

