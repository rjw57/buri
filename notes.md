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
