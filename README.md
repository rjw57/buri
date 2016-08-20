# Operating System for my 6502 homebrew micro

This is a work-in-progress operation system for Buri, my homebrew 6502
microcomputer system. The hardware design can be found at
https://github.com/rjw57/buri-6502-hardware.

The OS is in the form of an 8K ROM image. Compilation of this software requires
[cc65](https://github.com/cc65/cc65). Assuming that cc65 is installed under
``$HOME/opt/cc65``, you can clone the source and make the image:

```console
$ git clone https://github.com/rjw57/buri-6502-os
$ cd buri-6502-os
$ CC65_DIR=$HOME/opt/cc65 make
```

## Syscalls

Syscalls are made via the `BRK` software-interrupt instruction. When a `BRK` is
issued, the OS uses the value of the `X` register to index an OS call. Return
values, if any, are stored in the `A` register.

## Calling conventions

The default throughout is for the M and X flags to be set (8-bit accumulator and
index) which allows for more compact immediate addressing instructions. Code
which enables a 16-bit register should take care to reset it before calling
other public code. Generally, "public" means code in a separate source file.
Functions should preserve the X and Y registers but are free to corrupt the A
register (or use it as a return value).
