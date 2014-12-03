"""
Simulate the buri microcomputer.

Usage:
    burisim (-h | --help)
    burisim <rom>

Options:
    -h, --help          Show a brief usage summary.
"""
from __future__ import absolute_import, division, print_function
from builtins import * # pylint: disable=wildcard-import,redefined-builtin
from past.builtins import basestring # pylint: disable=redefined-builtin

from contextlib import contextmanager
from itertools import chain
import logging
import struct

from py65.devices.mpu6502 import MPU
from py65.memory import ObservableMemory
from docopt import docopt

_LOGGER = logging.getLogger(__name__)

class ReadOnlyMemoryError(RuntimeError):
    """Raised when code had attempter to write to read-only memory."""
    def __init__(self, address, value):
        self.address = address
        self.value = value
        super(ReadOnlyMemoryError, self).__init__(
            'Illegal attempt to write ${0.value:02X} to ${0.address:04X}'.format(self)
        )

class BuriSim(object):
    ROM_RANGE = 0xC000, 0x10000

    def __init__(self):
        # Behaviour flags
        self._raise_on_rom_write = True

        # Create memory space
        self.mem = ObservableMemory(addrWidth=MPU.ADDR_WIDTH)

        # Create microprocessor
        self.mpu = MPU(memory=self.mem)

        # Setup memory observers
        self._add_mem_observers()

        # Reset the computer
        self.reset()

    def load_rom(self, fobj_or_string):
        """Load a ROM image from the passed file object or filename-string. The
        ROM is truncated or repeated as necessary to fill the buri ROM region.

        """
        if isinstance(fobj_or_string, basestring):
            with open(fobj_or_string, 'rb') as fobj:
                self.load_rom_bytes(fobj.read())
        else:
            self.load_rom_bytes(fobj_or_string.read())

    def load_rom_bytes(self, rom_bytes):
        """Load a ROM image from the passed bytes object. The ROM is truncated
        or repeated as necessary to fill the buri ROM region.

        """
        _LOGGER.info(
            'Loading %s bytes from ROM image of %s bytes',
            BuriSim.ROM_RANGE[1] - BuriSim.ROM_RANGE[0], len(rom_bytes)
        )

        # Copy ROM from 0xC000 to 0xFFFF. Loop if necessary.
        with self.writable_rom():
            for addr, val in zip(range(*BuriSim.ROM_RANGE), chain(rom_bytes)):
                self.mem[addr] = struct.unpack('B', val)[0]

    def reset(self):
        """Perform a hardware reset."""
        # Reset MPU
        self.mpu.reset()

        # Read reset-vector
        self.mpu.pc = self.mpu.WordAt(MPU.ResetTo)

    def step(self):
        """Single-step the processor."""
        self.mpu.step()

    @contextmanager
    def writable_rom(self):
        """Return a context manager which will temporarily enable writing to
        ROM within the context and restore the old state after. Imagine this as
        a "EEPROM programmer".

        """
        old_val = self._raise_on_rom_write
        self._raise_on_rom_write = False
        yield
        self._raise_on_rom_write = old_val

    def _add_mem_observers(self):
        """Internal method to add read/write observers to memory."""
        def raise_hell(address, value):
            if self._raise_on_rom_write:
                raise ReadOnlyMemoryError(address, value)
        self.mem.subscribe_to_write(range(*BuriSim.ROM_RANGE), raise_hell)

def main():
    opts = docopt(__doc__)

    # Create simulator
    sim = BuriSim()

    # Read ROM
    sim.load_rom(opts['<rom>'])

    # Step
    sim.reset()
    while True:
        sim.step()

if __name__ == '__main__':
    main()
