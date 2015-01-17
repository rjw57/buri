// Mapping from pin names -> numbers
#pragma once
#ifndef GUARD_PINS_H__
#define GUARD_PINS_H__

#define MISO    2   // NB: (1)
#define MOSI    3   // NB: (1)
#define SCLK    4
#define DLOAD   8

// (1) Since the monitor board is a slave device w.r.t. the processor board,
// MISO is an OUTPUT and MOSI is an INPUT.

#endif // GUARD_PINS_H__
