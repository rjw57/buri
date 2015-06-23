---
priority: 0
layout: page
title: Operating System
permalink: /software/os/
categories: software
excerpt: >
  The Operating System is the ROM-resident code which is run on system reset and
  provides low-level driver routines for the Búri hardware along with the
  initial command-line interface.
---

<figure>
  <a href="{{site.imageurl}}/buri-os-1.jpg">
    <img src="{{site.imageurl}}/buri-os-1.jpg">
  </a>
  <figcaption>The Búri OS running over the serial port console.</figcaption>
</figure>

The Búri Operating System lives in ROM in the top 8KB of memory.  (See the
[memory map] for the full details.) The [source code] is available in the Búri
repository.  It is the first code which is run on reset. The OS at the moment is
fairly simplistic.

## Booting

On reset, the processor vectors to the code in [reset.s].  The OS then performs
the following tasks:

1. Disable interrupts.
1. Make sure that binary-mode arithmetic is enabled.
1. Clear page zero (sets all bytes to 0x00).
1. Initialise the [OS vector table](#vector-table).
1. Enable interrupts.
1. Jump to the initialisation routine.

At this point the processor is sanely bootstrapped. The initialisation routine
in [init.s] takes over to bring up the computer. It does the following:

1. Configure the serial adapter, if present.
1. Clear the terminal.
1. Write the "welcome" banner.
1. Enter the [command-line loop](#command-line).

## Vectors
<a name="vector-table"></a>

The OS provides some basic routines such as "output a byte" (``putc``) and
"block and read a byte" (``getc``). These routines are vectored through a table
starting at $0200. For example, when calling ``putc``, the OS will call the
little-endian 16-bit address stored at $0200. Code wishing to "patch" this
routine can replace this address with a pointer to their own code. This is how
the [LCD display] driver was developed.

## Command line
<a name="command-line"></a>

The init function then runs an endless loop of reading a line of input via
[readln] and executing it via the functions in the [cli] directory. The OS
command table is at the start of ROM and is searched for commands. At a later
date I intend to vector this as well to allow for commands to be soft-loaded
into the OS.

## Builtin commands

### echo

```
*echo <arg1> <arg2> <arg3>
```

Prints ``arg1`` through ``arg3`` to the output. Mostly used to test the CLI
parsing routines.

### call

```
*call <addr>
```

Takes a hexadecimal address ``<addr>`` and jumps to it via ``JSR``. When the
code calls ``RTS``, control returns to the OS.


### dump

```
*dump <addr> [<length>]
```

Provides a hes-dump of memory starting from hexadecimal address ``<addr>``. If
``<length>`` is present, it is a hexadecimal number giving the number of bytes
to dump. If omitted, a single page of 256 bytes is assumed.

### reset

```
*reset
```

Jumps to the OS reset vector. A software equivalent of pressing the reset
button. In later OS revisions I plan to make this "soft" reset detectably
different from a hard reset and make a warm reset different from a cold boot.

### peek

```
*peek <addr>
```

Display the hexadecimal representation of the byte at hexadecimal address
``<addr>`` in memory.

### poke

```
*poke <addr> <value>
```

Set the byte at hexadecimal address ``<addr>`` to the hexadecimal byte
``<value>``.

### xrecv

```
*xrecv <addr>
```

Begin receiving data via the [XMODEM] protocol and write it starting from
hexadecimal address ``<addr>``. This is the current method by which most data is
uploaded onto Búri.

[memory map]: {{ "/misc/memory-map/" | prepend: site.baseurl }}
[source code]: https://github.com/rjw57/buri/tree/master/os
[reset.s]: https://github.com/rjw57/buri/blob/master/os/src/reset.s
[init.s]: https://github.com/rjw57/buri/blob/master/os/src/init.s
[LCD display]: {{ site.baseurl }}/peripherals/lcd-display
[readln]: https://github.com/rjw57/buri/blob/master/os/src/io/readln.s
[cli]: https://github.com/rjw57/buri/tree/master/os/src/cli
[XMODEM]: https://en.wikipedia.org/wiki/XMODEM
