# Búri specific hardware information

## SPI bus

The SPI bus is wired into the 6522 VIA. CLK is wired to PA0, MOSI to PA1 and
MISO to PA7. Lines PA2, PA3 and PA4 are used to select devices. They are passed
to a 74HC138 3-to-8 decoder which provides the ~SELECT lines for the SPI
devices. SPI device "7" is unattached and used to denote "no device selected".

## Keyboard

Búri's keyboard is attached via the SPI bus. It appears as SPI device zero. It
is a SPI mode 1 device, i.e. CPOL=0, CPHA=1, and is byte-oriented with bytes
being transferred in most significant bit (MSB) first order.

A transaction begins with the device being selected and ends with it being
de-selected. A transaction always includes a transfer of one or two bytes.

There is a single input register in the controller which contains a keyboard
scancode. When a key is pressed or released on the keyboard, the scancode is
written to the register and the keyboard IRQ line is taken high. On Búri, the
IRQ line is connected to CA1 on the VIA. Reading the input register takes the
line low again.

### Control transactions

If the first byte sent by the master has the high bit set, it is a control byte.
The low 6 bits specifies a control code. After the control byte is sent, the
keyboard sends a response byte. If the master is uninterested in the response it
may de-select the device after the first byte.

The control bytes are as follows:

* 0x00: reset the keyboard controller
* 0x01: query state of input register. Respond with $FF if the register is full
  and 0x00 if empty.

### Read transactions

If the first byte has the high bit clear, the keyboard responds in the second
byte with the AT keyboard scancode in the input register. The keyboard uses "set
1" scancodes.

