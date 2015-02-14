// Update control lines based on global state

#pragma once
#ifndef GUARD_CONTROL_H
#define GUARD_CONTROL_H

// Update status_bits, address_bus and data_bus by reading the values present
// on the buses from the shift register.
void readBus();

// Update output lines to reflect desired state. For single-cycle and
// single-step, readBus must be called periodically.
void writeControlLines();

#endif GUARD_CONTROL_H
