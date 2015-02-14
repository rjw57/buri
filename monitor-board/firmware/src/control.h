// Update control lines based on global state

#pragma once
#ifndef GUARD_CONTROL_H
#define GUARD_CONTROL_H

// Set up pin modes and global state for control loop
void controlSetup();

// Update status_bits, address_bus and data_bus by reading the values present
// on the buses from the shift register. Then, update output lines to reflect
// desired state.
void controlLoop();

// Return true iff RDY, BE and ~RST are all high.
bool processorRunning();

// Return true iff RDY is low but BE and ~RST are high. I.e., the processor can
// be single-stepped.
bool processorCanBeStepped();

#endif // GUARD_CONTROL_H
