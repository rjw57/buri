# Búri specific hardware information

## Keyboard

Búri's keyboard is attached via the SPI bus. It appears as SPI device zero. It
is a SPI mode 1 device, i.e. CPOL=0, CPHA=1, and is byte-oriented with bytes
being transferred in most significant bit (MSB) first order.

A transaction begins with the device being selected and ends with it being
de-selected. A transaction always includes a transfer of one or two bytes.

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

