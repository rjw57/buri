#pragma once
#ifndef GUARD_IO_H__
#define GUARD_IO_H__

#include "Arduino.h"

// Directions to use with sendAndReceive.
#define LSB_FIRST 0
#define MSB_FIRST 1

// Send a byte along the MISO line. Return the bye which was simultaneously
// received over the MOSI line. If direction is LSB_FIRST then the data is sent
// LSB first, otherwise the data is sent MSB first.
byte sendAndReceive(byte output, int direction);

#endif // GUARD_IO_H__
