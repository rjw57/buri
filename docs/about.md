---
layout: page
title: About Búri
permalink: /about/
menuorder: 0
menu: top
---

# What is Búri?

Búri is my personal electronics project. I'm aiming to re-create a computer
system which would be recognisable to an electrical engineer from the 1980s. I'm
heavily inspired by systems such as the [Acorn System
1](http://en.wikipedia.org/wiki/Acorn_System_1) and [Apple
I](http://en.wikipedia.org/wiki/Apple_I) for hardware design and the [BBC
Microcomputer](http://en.wikipedia.org/wiki/BBC_Micro) for OS design.

# Why?

Around Christmas 2014, I decided I'd like a new long-term learning project. I've
always been interested in Software development but, until then, my knowledge of
hardware design has been limited to say the least. I had fond memories of
low-level programming the BBC Microcomputer when I was a youngster and wanted to
re-create some of that with my more modern knowledge.

Having an ambitious goal is very motivating for me and it's intellectually
satisfying to "fill the gaps" in my knowledge from Silicon up to C.

# How far along are you?

I managed to get a first version of the CPU board up and running. It's got 8KB
of EEPROM, 32KB of RAM and a [65C02] running at 2MHz. The CPU bus is exposed via
some Arduino-like connectors and it's got a somewhat over-spec'ed 5V regulated
supply on it. The EEPROM can be programmed in situ via a "monitor" system which
also allows for single-stepping and examining memory independently of the
processor.

Separate to the CPU and monitor modules, I've got a working serial port module
which, when combined with a FTDI USB-to-serial adaptor, allows for interaction
with the computer and uploading programs via [XMODEM].

I've got a version of Enhanced BASIC working on the system and have managed to
compile, upload and run some C-code via the [CC65] compiler.

I'm currently writing the OS and developing some peripherals for a "v2" board
which will have some more on-board functionality.

[XMODEM]: http://en.wikipedia.org/wiki/XMODEM
[65C02]: http://en.wikipedia.org/wiki/WDC_65C02
[CC65]: http://cc65.github.io/doc/

# Búri? Why the weird name?

I name all of my computers after mythological figures. When I was coming up with
the initial design I was also, separately, learning Old Norse. It seemed fitting
to name a computer which is aiming to be like the first home computer systems
after [the first Norse god](http://en.wikipedia.org/wiki/B%C3%BAri).

