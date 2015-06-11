---
priority: 5
layout: page
categories: peripheral
permalink: /peripherals/lcd-display/
title: LCD Display
excerpt: >
  Interfacing a 20&times;4 LCD display based on the popular HD44780 display chip
  to Búri.
---

<figure>
  <img src="http://placehold.it/800x400" alt="A typical LCD display">
  <figcaption>A typical LCD display module</figcaption>
</figure>

The [HD4480] is a popular chipset used in all manner of small LCD displays. This
page documents how to wire one up to the 6502 processor bus and some code to
control it.

## Bus interfacing

The electrical interface to the HD4480 is fairly 6502 friendly. There are 8
parallel data lines D[0&hellip;7] which are set by the HD4480 when reading data
from the display and read by the HD4480 when writing. There is a single register
select (RS) line which is low to indicate access to the control register(s) and
high to read/write data from the display itself. There is the usual R/<s>W</s>
line to indicate whether data is being read from or written to the display and
there is a display enable (E) line which is taken high to indicate to the
display that the values on the control/data lines are intended for it.

Reading data from the display is a relatively unsurprising affair:

<ol>
  <li>Set RS to indicate whether one is reading the busy flag/RAM address or
  reading data from the display.</li>
  <li>Set R/<s>W</s> high.</li>
  <li>Set E high.</li>
  <li>Read byte from D[0&hellip;7].</li>
  <li>Set E low</li>
</ol>

Similarly, writing data to the display is straightforward:

<ol>
  <li>Set RS to indicate whether one is writing the control register or sending
  data.</li>
  <li>Set R/<s>W</s> low</li>
  <li>Set byte on D[0&hellip;7].</li>
  <li>Set E high.</li>
  <li>Set E low</li>
</ol>

This is very similar to the 6502 read/write cycles. The subtlety is in how the E
signal is generated. If it is by some address line decoding, which it is on
Búri, then the E signal will change during &phi;1 which is <em>before</em> the
R/<s>W</s> and data lines are stable. This is easily fixed by making E
conditional on &phi;2 being high.

All of the displays I have can run at 2MHz so no additional logic is needed if
the 6502 is running at 2MHz or slower. Thankfully Búri is a 2MHz machine by
design so I can stop here. I may need to re-visit the bus adapter at a later
date if I move Búri to 4MHz or greater.

<figure>
  <a href="{{ "lcd-bus-adapter.svg" | prepend: site.imageurl }}">
    <img src="{{ "lcd-bus-adapter.png" | prepend: site.imageurl }}">
  </a>
  <figcaption>
    The Búri bus adapter circuitry for interfacing a HD44780-style LCD display.
  </figcaption>
</figure>

The complete bus logic is shown above. Here we've used a 74138 3-to-8 decoder to
select out the bottom two bytes from [I/O area 7] Búri will take <s>IO7</s> low when bytes
in the range $DFF0&ndash;$DFFF are accessed. We use A0 as register
select and feed A[1&hellip;3] into the '138. We use a single 7400 NAND gate to
condition E on &phi;2 and a couple of 7404 NOT gates to flip some signals
around.

<aside>
We could've just used some NAND gates to select the display when A1 = A2 = A3 =
low but using the '138 is useful since it exposes some other lines which can be
used to select other peripherals in I/O area 7 such as the [serial port].
</aside>

## Testing

According to the [datasheet], the display is controlled by writing to register 0
(which is at $DFF0 using the circuit above) and data is written to register 1
(exposed at $DFF1). The control bytes we need to send are:

* $38: enable 8-bit mode, 2 line display and 5&times;8 font.
* $0D: switch display on and have "blinking block"-style cursor.
* $01: clear display and move cursor to home position.

With the [Búri OS], these steps can be performed via the ``poke`` command:

```text
*poke dff0 38
*poke dff0 0d
*poke dff0 01
```

Writing a message can be performed by writing character codes one at a time to
$DFF1:

```text
*poke dff1 48
*poke dff1 65
*poke dff1 6c
*poke dff1 6c
*poke dff1 6f
*poke dff1 21
```

## Software

```asm
.proc display_addr_to_pos
.endproc
```

[HD4480]: http://en.wikipedia.org/wiki/Hitachi_HD44780_LCD_controller
[datasheet]: https://www.sparkfun.com/datasheets/LCD/HD44780.pdf
[I/O area 7]: {{ site.baseurl }}/misc/memory-map/
[serial port]: {{ site.baseurl }}/peripherals/serial-port/
[Búri OS]: {{ site.baseurl }}/software/os/
