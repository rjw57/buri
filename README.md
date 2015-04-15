# Buri: a homebrew 6502 microcomputer

This repository contains my work on designing, building and programming a 6502
microcomputer from scratch. The 6502 was the CPU used in the original Apple 1,
BBC Microcomputer, NES console and many other systems from the late 70s/early
80s.

I want to learn digital electronics, lower-level programming and a little about
computer history. This project is part of my endeavours in that regard.

My microcomputer is intended to sit somewhere around 1980-82 in terms of its
technology but I won't be afraid to "borrow" from 2010s-era technology as
longas the result would still be understandable to an electrical engineer from
the 80s.

## Contents of this repository

The [hardware](hardware) directory contains schematics, etc for the
microcomputer hardware itself. Pre-rendered plots of PCB layout and schematics
can be found in gerber and PDF format in the [CPU board plot
directory](hardware/cpu-board/plots).

The [sim](sim) directory contains a simulator for the microcomputer.  It's
pretty slow and I only really use it to enable development of the operating
system without waiting for the ROM to re-flash.

The [os](os) directory contains a basic ROM-based operating system for the
computer.

The [examples](examples) directory contains example programs to run on the
microcomputer.

## Why "Buri"?

[Búri](http://en.wikipedia.org/wiki/B%C3%BAri) was the first of the Norse gods.
I name all of my machines on my network after gods and goddesses and so it made
sense to name the technologically earliest of them after the first god in the
Norse pantheon.

## Licence

The parts of this project which are my own work are released under a
[MIT-style licence](COPYING.txt). Feel free to use the resources in this
repository if they are of educational use. If you find it interesting, do drop
me a line at rich.buri@richwareham.com.
