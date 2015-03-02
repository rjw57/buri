# Emulator for buri, my homebrew 6502 machine

This is a work-in-progress emulator for Buri, my homebrew 6502 computer.
Hardware designs can be found at https://github.com/rjw57/buri-6502-hardware
and the OS source can be found at https://github.com/rjw57/buri-6502-os.

## Installation

Clone this repo and then install via ``pip``:

```console
$ cd /path/to/this/repo
$ pip install -r requirements.txt
$ pip install -e .
```

## Running

There are two utilities ``burisim`` and ``buritk`` which are a command-line and
GUI emulator respectively. Both are somewhat immature.

### Virtual serial device

The ``burisim`` command accepts a serial device to connect ACIA1 to via the
``-serial`` parameter. The ``socat`` utility can be used to create a
pseudo-terminal for this device:

```console
$ socat PTY,link=/tmp/a,raw,echo=0 PTY,link=/tmp/b,raw,echo=0
$ picocom --noinit /tmp/a
$ burisim --serial /tmp/b /path/to/rom.bin
```

## Acknowledgements

The core of the 6502 emulator is [py65](https://github.com/mnaberez/py65/).

The VT100 widget for tkinter is based on [Twisted
Conch](https://github.com/racker/python-twisted-conch) and specifically work by
Paul Swartz and Jean-Paul Calderone. See the
[license](https://github.com/racker/python-twisted-conch/blob/master/LICENSE)
there for more information.
