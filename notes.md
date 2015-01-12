# Compute board

RDY has a resistor so that it may be pulled low for single-stepping. (~IRQ has
a resistor for a similar reason.)

The address lines to the RAM are ordered for convenience of aligning with the
ROM. We can permute the address lines on the RAM; it doesn't matter if the RAM
is scrambled.

In-circuit-programming (ICP) of the EEPROM is enabled by moving jumpers as
directed in the schematic, pulling ~RST low and using R/~W as ~WE and A14 as
~OE. The EEPROM programmer may get power from the VCC/GND lines on the bus.
This is intended to make the circuit compatible with the Arduino-based
[MEEPROMER](http://www.ichbinzustaendig.de/dev/meeprommer-en).

Note that the reset circuit has a pull up resistor to enable external pulling
low of ~RST.

SYNC and RDY are exposed on a jumper to allow external single-stepping of the
CPU.

## Monitor board

Use single 8-bit universal shift register for read/write to data bus. Set
A0-A15 via two 8-bit parallel out shift registers.

BE signal on processor is used as ~OE on registers -> when processor has bus,
SR pins are set to high impedance.

D0-D8 - S0, S1, DSR, CP, Q0

A0-A15 - SHCP, STCP, DS

Shared - ~MR

=> 9 I/O lines to arduino. Outputs: MR, S0, S1, DSR, CP, SHCP, STCP, DS. Inputs: Q0.

Maybe add R/~W as another output line? It may be that one of S0/S1 could suffice.

We'll also need to take over PHI2 as a bus clock. Maybe separate processor BE
from halt/single step? In which case we'd want to replace A0-A15 with universal
shift registers too.

~WE for EEPROM *only* controllable from monitor

MR acts as processor halt signal?

Another option:

Bidirectional shift registers for address lines too allowing for observation of
processor?


