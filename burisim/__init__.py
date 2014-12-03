"""
Simulate the buri microcomputer.

Usage:
    burisim (-h | --help)
    burisim <rom>

Options:
    -h, --help          Show a brief usage summary.
"""
from __future__ import print_function
from future.builtins import * # pylint: disable=wildcard-import

from itertools import chain
import struct

from py65.devices.mpu6502 import MPU
from py65.memory import ObservableMemory
from docopt import docopt

def main():
    opts = docopt(__doc__)

    # Read ROM
    rom_bytes = open(opts['<rom>'], 'rb').read()
    print('Read {} bytes of ROM'.format(len(rom_bytes)))

    # Create memory space
    mem = ObservableMemory(addrWidth=MPU.ADDR_WIDTH)

    # Create microprocessor
    mpu = MPU(memory=mem)

    # Copy ROM from 0xC000 to 0xFFFF. Loop if necessary.
    for addr, val in zip(range(0xC000, 0x10000), chain(rom_bytes)):
        mem[addr] = struct.unpack('B', val)[0]

    # Register all observers on this memory
    setup_memory_map(mem)

    # Reset CPU reading reset vector
    mpu.pc = mpu.WordAt(0xFFFC)
    while True:
        mpu.step()

def setup_memory_map(mem):
    """Registers observers on ObservableMemory mem corresponding to the buri
    memory map.

    """
    set_ro_mem_(mem, range(0xC000, 0xFFFF))

class ReadOnlyMemoryError(RuntimeError):
    """Raised when code had attempter to write to read-only memory."""
    def __init__(self, address, value):
        self.address = address
        self.value = value
        super(ReadOnlyMemoryError, self).__init__(
            'Illegal attempt to write {.address} to {.value}'.format(self)
        )

def set_ro_mem_(mem, rng):
    """Mark the specified range of memory as read-only. Raise a
    ReadOnlyMemoryError if read from.

    """
    def raise_hell(address, value):
        raise ReadOnlyMemoryError(address, value)
    mem.subscribe_to_write(rng, raise_hell)

if __name__ == '__main__':
    main()
