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

