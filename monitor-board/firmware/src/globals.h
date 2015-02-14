// The very name of this file should provoke dread in the hearts of All True
// Developers. That being said, having global state like this is just an
// application of the zero, one, many rule with the earnest hope that one is
// sufficiently many.

#pragma once
#ifndef GUARD_GLOBALS_H
#define GUARD_GLOBALS_H

#include <Arduino.h> // for "byte"

// 16-bit address bus value
extern unsigned int address_bus;

// 8-bit data bus value
extern byte data_bus;

// Status bits. Some combination of StatusBitMask values.
extern byte status_bits;

// Set to true to raise the HALT line on the next iteration. Set to false to
// lower it.
extern bool halt_request;

// Set to true to single cycle the processor on the next iteration when it is
// next halted. After the processor is single cycled, this flag is reset to
// false.
extern bool cycle_request;

// Set to true (along with cycle_request) to continue single-cycling until the
// SYNC line goes high. In this way the processor is single *instruction*
// stepped rather than single *cycle*.
extern bool skip_to_next_sync;

// See status_bits.
enum StatusBitMask {
    SB_RWBAR        = 0x01,
    SB_IRQBAR       = 0x02,
    SB_BE           = 0x04,
    SB_SYNC         = 0x08,
    SB_RSTBAR       = 0x10,
    SB_RDY          = 0x20,
};

#endif // GUARD_GLOBALS_H
