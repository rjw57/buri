---
priority: 0
layout: page
title: CPU Board
permalink: /hardware/cpu-board/
categories: hardware
excerpt: >
  The CPU board is the main component of the Búri computer. It houses the CPU,
  ROM and RAM along with the address decode circuitry and I/O select lines.
---

<figure>
  <img alt="The assembled board"
    src="{{ "cpu-board.jpg" | prepend: site.imageurl }}">
  <figcaption>The assembled CPU board.</figcaption>
</figure>

The CPU board was the first PCB I had professionally made. I had had a god at
etching my own PCBs before but it became readily apparent that trying to
home-etch something as complex as Búri's main CPU board was not going to work
out well.

I got the boards made by [Seeed Studio](http://www.seeedstudio.com/) for
&pound;20 for 10 boards including delivery. I thought this was a pretty good
deal and I was willing to pay a premium for the pleasure of having my own PCB
relatively early on.

# Design

I had the first version of Búri prototyped on the breadboard. I toyed with
wiring up a more permanent version on a generic PCB but the idea of having to
route the 16 address bus lines and 8 data bus lines filled me with dread. One
very great advantage with PCBs is that a lot of wiring is no more onerous than a
little.

# Issues

When I finally got the boards home, I did some visual inspection to make sure
everything looked good and wired them up. Imagine my disappointment when it
didn't work. Hooking the CPU board up to my [monitor board] it appeared that the
ROM was correctly executing but zero-page wasn't being cleared. Indeed reading
and writing to RAM was as if there was no RAM there.

After checking for a poorly seated chip, I realised my error. The RAM has both
an inverted chip select (<s>CS</s>) and output enable (<s>OE</s>) line. Since I
use the <s>CE</s> line to select the RAM from the address decode circuitry, I
keep <s>OE</s> low. Or, at least, that's what I should've done. A "thinko" meant
that I actually had <s>OE</s> wired high meaning that the RAM was essentially
disconnected from the circuit.

[monitor board]: {{ "/hardware/monitor-board/" | prepend: site.baseurl }}

<figure>
  <ul class="image-strip">
    <li class="image-strip-image">
      <a href="{{ "bodge-1.jpg" | prepend: site.imageurl }}">
        <img src="{{ "bodge-1-thumb.jpg" | prepend: site.imageurl }}">
      </a>
    </li>
    <li class="image-strip-image">
      <a href="{{ "bodge-2.jpg" | prepend: site.imageurl }}">
        <img src="{{ "bodge-2-thumb.jpg" | prepend: site.imageurl }}">
      </a>
    </li>
  </ul>
  <figcaption>A selection of bodges.</figcaption>
</figure>

This was an error in the PCB which was right there in the schematic when I
looked again. No matter how much checking you do, there'll always be something.
Looking carefully at the board, I noted that if I could break the track, I could
pull <s>OE</s> low and bridge the broken track with a couple of bodge wires.

At this point, having nine spare boards was useful since I could practise the
delicate surgery required to drill a tiny hole and break the track. After
seeming to succeed on some of the unpopulated boards, I held my breath and
operated on the real board.

Thankfully all went well a nd the board booted. Using the [monitor board] I
could see that the zero page had been cleared by the OS ROM and so all was well.

# Programming the EEPROM


