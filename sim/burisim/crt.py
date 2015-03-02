"""
CRT emulator

"""
# Make py2 like py3
from __future__ import (absolute_import, division, print_function, unicode_literals)
from builtins import (  # pylint: disable=redefined-builtin, unused-import
    bytes, dict, int, list, object, range, str,
    ascii, chr, hex, input, next, oct, open,
    pow, round, super,
    filter, map, zip
)

import logging

import pkg_resources
from PIL import Image, ImageFont, ImageDraw

log = logging.getLogger(__name__)

class ScreenMemory(object):
    """Character memory."""

    # Size of screen in characters. Width, height.
    SCREEN_SIZE_CH = (48, 26)

    # Size of screen memory area in bytes
    SCREEN_SIZE_BYTES = SCREEN_SIZE_CH[0] * SCREEN_SIZE_CH[1]

    # Load screen font
    CH_FONT = ImageFont.load(
        pkg_resources.resource_filename(__name__, 'data/bedstead-20.pil')
    )

    # Size of character in pixels
    CH_SIZE = (12, 20)

    # Size of screen in pixels
    SCREEN_SIZE_PX = (
        SCREEN_SIZE_CH[0] * CH_SIZE[0],
        SCREEN_SIZE_CH[1] * CH_SIZE[1]
    )

    # Size of screen *buffer* in bytes
    SCREEN_BUF_SIZE_BYTES = SCREEN_SIZE_PX[0] * SCREEN_SIZE_PX[1]

    def __init__(self):
        self.data = bytearray(b'\0' * ScreenMemory.SCREEN_SIZE_BYTES)
        self.image = Image.new('RGB', ScreenMemory.SCREEN_SIZE_PX)

    def write(self, idx, val):
        if idx < 0 or idx >= ScreenMemory.SCREEN_SIZE_BYTES:
            raise IndexError

        self.data[idx] = val

        draw = ImageDraw.Draw(self.image)

        # Where is top-left of character in screen pixels?
        c_col = idx % ScreenMemory.SCREEN_SIZE_CH[0]
        c_row = (idx - c_col) // ScreenMemory.SCREEN_SIZE_CH[0]
        p_col = c_col * ScreenMemory.CH_SIZE[0]
        p_row = c_row * ScreenMemory.CH_SIZE[1]

        fg_col, bg_col = 0xFFFFFF, 0x000000

        draw.rectangle(
            ((p_col, p_row), (p_col+ScreenMemory.CH_SIZE[0], p_row+ScreenMemory.CH_SIZE[1])),
            fill=bg_col,
        )
        draw.text(
            (p_col, p_row+1), chr(self.data[idx]),
            font=ScreenMemory.CH_FONT, fill=fg_col,
        )

    def read(self, idx):
        return int(self.data[idx])

    def observe_mem(self, mem, start):
        """Add appropriate read/write observers to memory starting at a given
        address.

        """
        log.info(
            'registering screen memory from 0x%X to 0x%X',
            start, start + ScreenMemory.SCREEN_SIZE_BYTES - 1
        )
        addr_rng = range(start, start+ScreenMemory.SCREEN_SIZE_BYTES)
        mem.subscribe_to_write(addr_rng, lambda addr, val: self.write(addr-start, val))
        mem.subscribe_to_read(addr_rng, lambda addr: self.read(addr-start))

