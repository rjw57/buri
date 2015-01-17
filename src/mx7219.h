// Utilities for MX7219 chip
#pragma once
#ifndef GUARD_MX7219_H__
#define GUARD_MX7219_H__

#include "Arduino.h"

// MAX7219 registers.
#define MX7219_NOP          0x0
#define MX7219_DIGIT_0      0x1
#define MX7219_DECODE_MODE  0x9
#define MX7219_INTENSITY    0xA
#define MX7219_SCN_LIMIT    0xB
#define MX7219_SHUTDOWN     0xC
#define MX7219_DPLY_TEST    0xF

// A simple font for the MAX7219.
extern byte MX7219_FONT[];

// Number of characters in the MX7219 font.
extern const int MX7219_FONT_N_CHARS;

// Initialise MX7219 registers
void setupMX7219();

// Set MX7219 register to a given value.
void setMX7219Reg(byte reg, byte value);

#endif // GUARD_MX7219_H__
