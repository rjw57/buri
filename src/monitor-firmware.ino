// Firmware for monitor board

#include "debounced_switch.h"
#include "edge_trigger.h"
#include "mx7219.h"
#include "pins.h"
#include "serialstatemachine.h"

// 16-bit address bus value
unsigned int address_bus;

// 8-bit data bus value
byte data_bus;

// Status bits
byte status_bits;

enum StatusBitMask {
    SB_RWBAR        = 0x01,
    SB_IRQBAR       = 0x02,
    SB_BE           = 0x04,
    SB_SYNC         = 0x08,
    SB_RSTBAR       = 0x10,
    SB_RDY          = 0x20,
};

// How long to show display test for
const int DPY_TST_DURATION = 500; // milliseconds

// Are we wanting the processor to be halted?
bool halt_request;

// Should we cycle the processor?
bool cycle_request;

DebouncedSwitch mode_switch(BTN_MODE);
DebouncedSwitch select_switch(BTN_SELECT);

EdgeTrigger mode_trigger;
EdgeTrigger select_trigger;

const int MAX_CMD_LEN = 31;
byte cmd_buf[MAX_CMD_LEN+1];
int cmd_len;

SerialState serial_state;

// Write command prompt and return reading command state.
SerialState serialPrompt() {
    // Reset current command
    cmd_buf[0] = '\0';
    cmd_len = 0;

    Serial.print("> ");
    return { .next = &readingCommandState };
}

SerialState readingCommandState(byte ch) {
    switch(ch) {
        // handle backspace
        case 8:
        case 127:
            if(cmd_len > 0) {
                Serial.write(8);
                Serial.write(' ');
                Serial.write(8);
                cmd_len--;
                cmd_buf[cmd_len] = '\0';
            } else {
                // bell
                Serial.write(7);
            }
            break;

        // handle enter
        case 10:
        case 13:
            Serial.println("");
            return processCommand();
            break;

        default:
            // Only accept printable chars.
            if(ch < 0x20) {
                // Bell
                Serial.write(7);
            } else if(cmd_len < MAX_CMD_LEN) {
                // Add character to command buffer
                cmd_buf[cmd_len+1] = '\0';
                cmd_buf[cmd_len] = ch;
                cmd_len++;

                // Echo character to output
                Serial.write(ch);
            } else {
                // Bell
                Serial.write(7);
            }
            break;
    }

    return { .next = &readingCommandState };
}

void printHelp() {
    Serial.println("?       - show brief help message");
    Serial.println("p       - print current address/data bus");
    Serial.println("h       - toggle halt state");
    Serial.println("c       - single cycle");
}

SerialState processCommand() {
    if(cmd_buf[0] == 'p') {
        // print current state
        Serial.print("A: ");
        Serial.print(address_bus, HEX);
        Serial.print(" D: ");
        Serial.print(data_bus, HEX);
        Serial.println("");
    } else if(cmd_buf[0] == '?') {
        printHelp();
    } else if(cmd_buf[0] == 'h') {
        halt_request = !halt_request;
        Serial.print("halt ");
        Serial.println(halt_request ? "on" : "off");
    } else if(cmd_buf[0] == 'c') {
        cycle_request = true;
    } else {
        Serial.println("unknown cmd");
        printHelp();
    }
    return serialPrompt();
}

void pollSerial() {
    while(Serial.available() > 0) {
        serial_state = serial_state.next(Serial.read());
    }
}

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
    serial_state = serialPrompt();

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
    halt_request = false;
    cycle_request = false;

    // OK, all done, just wait for display test to time out
    while(millis() - dt_shown_at < DPY_TST_DURATION) {
        // NOP
    }
    setMX7219Reg(MX7219_DPLY_TEST, 0x00);
}

void loop() {
    // Poll serial port
    pollSerial();

    // Poll switches
    mode_switch.poll();
    select_switch.poll();

    // Update triggers
    mode_trigger.update(mode_switch.state() == HIGH);
    select_trigger.update(select_switch.state() == HIGH);

    if(mode_trigger.triggered()) {
        halt_request = !halt_request;
    }

    cycle_request = cycle_request || select_trigger.triggered();

    // Update control lines
    digitalWrite(HALT, halt_request ? HIGH : LOW);

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

    // Update status bits
    setMX7219Reg(MX7219_DIGIT_0 + 6, status_bits);

    // Check halt state by directly observing RDY
    if(status_bits & SB_RDY) {
        // Processor running, show running dots
        int point = (millis() >> 7) % 6;
        for(int digit=0; digit<6; ++digit) {
            setMX7219Reg(MX7219_DIGIT_0 + digit, (point == (5-digit)) ? 0x80 : 0x00);
        }
    } else {
        // step only makes sense if processor halted
        if(cycle_request) {
            // Pulse step pin
            digitalWrite(STEP, HIGH);
            digitalWrite(STEP, LOW);

            // Reset cycle request
            cycle_request = false;
        }

        // Update address bus
        setMX7219Reg(MX7219_DIGIT_0 + 0, MX7219_FONT[address_bus & 0xF]);
        setMX7219Reg(MX7219_DIGIT_0 + 1, MX7219_FONT[(address_bus>>4) & 0xF]);
        setMX7219Reg(MX7219_DIGIT_0 + 2, MX7219_FONT[(address_bus>>8) & 0xF]);
        setMX7219Reg(MX7219_DIGIT_0 + 3, MX7219_FONT[(address_bus>>12) & 0xF]);

        // Update data bus
        setMX7219Reg(MX7219_DIGIT_0 + 4, MX7219_FONT[data_bus & 0xF]);
        setMX7219Reg(MX7219_DIGIT_0 + 5, MX7219_FONT[(data_bus>>4) & 0xF]);
    }

    // Clear mode/select trigger
    mode_trigger.clear();
    select_trigger.clear();
}
