#include "serialcli.h"

#include "globals.h"
#include "serialstatemachine.h"

const int MAX_CMD_LEN = 31;
byte cmd_buf[MAX_CMD_LEN+1];
int cmd_len;

// States
static SerialState readingCommandState(byte ch);

// Process command stored in cmd_buf and return state to transition to.
static SerialState processCommand();

// Print a brief usage summary to the serial port.
static void printHelp();

// EXTERNAL

SerialState startSerialPrompt() {
    // Reset current command
    cmd_buf[0] = '\0';
    cmd_len = 0;

    Serial.print("> ");
    return { .next = &readingCommandState };
}

// INTERNAL

// State machine
static SerialState readingCommandState(byte ch) {
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

static void printHelp() {
    Serial.println("?       - show brief help message");
    Serial.println("p       - print current address/data bus");
    Serial.println("h       - toggle halt state");
    Serial.println("c       - single cycle");
    Serial.println("s       - single step");
}

static SerialState processCommand() {
    if((cmd_buf[0] == 'p') && (cmd_len == 1)) {
        // print current state
        Serial.print("A: ");
        Serial.print(address_bus, HEX);
        Serial.print(" D: ");
        Serial.print(data_bus, HEX);
        Serial.println("");
    } else if((cmd_buf[0] == '?') && (cmd_len == 1)) {
        printHelp();
    } else if((cmd_buf[0] == 'h') && (cmd_len == 1)) {
        halt_request = !halt_request;
        Serial.print("halt ");
        Serial.println(halt_request ? "on" : "off");
    } else if((cmd_buf[0] == 'c') && (cmd_len == 1)) {
        cycle_request = true;
    } else if((cmd_buf[0] == 's') && (cmd_len == 1)) {
        cycle_request = true;
        skip_to_next_sync = true;
    } else {
        Serial.println("unknown cmd");
        printHelp();
    }
    return startSerialPrompt();
}
