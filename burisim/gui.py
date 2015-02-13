"""
Tk based GUI for the buri simulator.

Usage:
    {progname} (-h | --help)
    {progname} [options] <rom>

Options:
    -h, --help          Show a brief usage summary.
    -v, --verbose       Increase verbosity.

The ROM image is loaded from <rom>.

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
import os
import sys

from burisim import BuriSim

from docopt import docopt
import tkinter as tk
from PIL import ImageTk

# Fixup doc string
__doc__ = __doc__.format( # pylint: disable=redefined-builtin
    progname=os.path.basename(sys.argv[0])
)

log = logging.getLogger(__name__)

class BuriApplication(object):
    def __init__(self, sim, master=None):
        self._sim = sim

        # Self-test screen memory
        for idx in range(self._sim.screen.SCREEN_SIZE_BYTES):
            self._sim.screen.write(idx, idx & 0xFF)

        self._master = master
        self._create_widgets()
        self._main_frame.winfo_toplevel().title('Buri microcomputer')

        # Register idle-callback
        self._main_frame.after_idle(self._idle_cb)

        # Register GUI update callback
        self._main_frame.after(33, self._redraw_cb)

    def run(self):
        """Run main frame's event loop."""
        return self._main_frame.mainloop()

    def _idle_cb(self):
        # Run 1000 steps
        for _ in range(1000):
            self._sim.step()
        self._main_frame.after(1, self._idle_cb)

    def _redraw_cb(self):
        self._refresh_screen()
        self._main_frame.after(33, self._redraw_cb)

    def _create_widgets(self):
        self._main_frame = tk.Frame(self._master)

        # Create and place tool bar
        self._tool_bar = self._create_tool_bar()
        self._tool_bar.grid(row=0, sticky=tk.W)

        # Create and place screen image canvas
        screen = tk.Canvas(
            self._main_frame,
            width=self._sim.screen.SCREEN_SIZE_PX[0],
            height=self._sim.screen.SCREEN_SIZE_PX[1],
            bg='#FFFFFF'
        )
        self._screen_photo_im = ImageTk.PhotoImage('RGB', self._sim.screen.SCREEN_SIZE_PX)
        self._refresh_screen()
        screen.create_image(1, 1, image=self._screen_photo_im, anchor=tk.N+tk.W)
        screen.grid(row=1)

        # Lay out main frame
        self._main_frame.grid()

    def _refresh_screen(self):
        self._screen_photo_im.paste(self._sim.screen.image)

    def _create_tool_bar(self):
        """Create tool bar frame and connect button event handlers."""
        tool_bar = tk.Frame(self._main_frame)
        #run_b = tk.Button(tool_bar, text='Run')
        #run_b.grid(column=0, row=0)
        #step_b = tk.Button(tool_bar, text='Step')
        #step_b.grid(column=1, row=0)
        reset_b = tk.Button(tool_bar, text='Reset', command=lambda: self._sim.reset())
        reset_b.pack(side='left')
        return tool_bar

def main():
    # Parse command line options
    opts = docopt(__doc__)
    logging.basicConfig(
        level=logging.INFO if opts['--verbose'] else logging.WARN,
        stream=sys.stderr, format='%(name)s: %(message)s'
    )

    # Create simulator
    sim = BuriSim()

    # Read ROM
    sim.load_rom(opts['<rom>'])

    # Reset
    sim.reset()

    # Create gui application and run main loop
    app = BuriApplication(sim)
    app.run()

if __name__ == '__main__':
    main()
