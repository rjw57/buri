// State machine for serial CLI

#pragma once
#ifndef GUARD_SERIAL_CLI_H
#define GUARD_SERIAL_CLI_H

#include "serialstatemachine.h"

// Write command prompt to serial device and return state machine's "listening"
// state.
SerialState startSerialPrompt();

#endif // GUARD_SERIAL_CLI_H
