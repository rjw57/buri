---
priority: 0
layout: page
title: CPU Board (v3)
permalink: /hardware/cpu-board-3/
categories: hardware
excerpt: >
  The CPU board is the main component of the Búri computer. It houses the CPU,
  ROM and RAM along with the address decode circuitry and I/O select lines.
---

<figure>
  <img alt="The v3.1 board"
    src="{{ "cpu-board-3.jpg" | prepend: site.imageurl }}">
  <figcaption>The CPU and UART board.</figcaption>
</figure>

The version 3 CPU board included an upgraded processor: the
[W65C816](http://www.westerndesigncenter.com/wdc/w65c816s-chip.cfm). This
processor has a 24-bit address bus and extends the 8-bit A, X and Y registers of
the 6502 to 16-bit. The version 3 CPU board was designed to make full use of the
512KiB SRAM chip I'd obtained.

