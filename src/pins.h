// Mapping from pin names -> numbers
#pragma once
#ifndef GUARD_PINS_H__
#define GUARD_PINS_H__

#define MISO    2   // NB: (1)
#define MOSI    3   // NB: (1)
#define SCLK    4
#define DLOAD   8

#define HALT    6
#define STEP    7

#define BTN_MODE    12
#define BTN_SELECT  11

#define BUS_SDTA    5
#define BUS_PLBAR   9
#define BUS_CP      10

// (1) Since the monitor board is a slave device w.r.t. the processor board,
// MISO is an OUTPUT and MOSI is an INPUT.

#endif // GUARD_PINS_H__
