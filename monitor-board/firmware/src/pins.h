// Mapping from pin names -> numbers
#pragma once
#ifndef GUARD_PINS_H__
#define GUARD_PINS_H__

#define MISO        3
#define MOSI        2
#define SCLK        4
#define BUS_PLBAR   5
#define DLOAD       8

#define HALT    6
#define STEP    7

#define BTN_MODE    12
#define BTN_SELECT  11

// The following pins are INPUT or OUTPUT depending on whether the
// corresponding control lines are being pulled low or not.
#define RSTBAR      A0


#endif // GUARD_PINS_H__
