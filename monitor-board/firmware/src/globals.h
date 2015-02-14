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

// See status_bits.
enum StatusBitMask {
    SB_RWBAR        = 0x01,
    SB_IRQBAR       = 0x02,
    SB_BE           = 0x04,
    SB_SYNC         = 0x08,
    SB_RSTBAR       = 0x10,
    SB_RDY          = 0x20,
};

// Status bits. Some combination of StatusBitMask values.
extern byte status_bits;

// Set to true to raise the HALT line. Set to false to lower it.
extern bool halt;

enum StepState {
    SS_NONE,
    SS_CYCLE,
    SS_INST,
    SS_INST_WAITING_FOR_SYNC, // after SS_INST
};

// Set to SS_CYCLE to single cycle the processor when next halted. Set to
// SS_INST to single instruction step. Reset to SS_NONE after step.
extern StepState step_state;

// Set to true to pull RST low.
extern bool pull_rst_low;

#endif // GUARD_GLOBALS_H
