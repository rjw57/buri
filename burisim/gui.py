"""
Tk based GUI for the buri simulator.

Usage:
    {progname} (-h | --help)
    {progname} [options] <rom>

Options:
    -h, --help          Show a brief usage summary.
    -q, --quiet         Decrease verbosity.

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
import threading

from burisim import BuriSim, MachineError

from docopt import docopt
import tkinter as tk
from PIL import ImageTk

# Fixup doc string
__doc__ = __doc__.format( # pylint: disable=redefined-builtin
    progname=os.path.basename(sys.argv[0])
)

log = logging.getLogger(__name__)

# pylint: disable=too-many-instance-attributes, too-few-public-methods
class BuriApplication(object):
    def __init__(self, sim, master=None, rom_image=None):
        self._sim = sim
        self._rom_image_fn = rom_image

        # Self-test screen memory
        for idx in range(self._sim.screen.SCREEN_SIZE_BYTES):
            self._sim.screen.write(idx, idx & 0xFF)

        self._master = master
        self._main_frame = tk.Frame(self._master)

        # Create variables controlled by GUI
        self._halt = tk.IntVar(self._main_frame)
        self._halt.trace('w', self._halt_changed)
        self._pc_label = tk.StringVar(self._main_frame)

        self._create_widgets()
        self._main_frame.winfo_toplevel().title('Buri microcomputer')

        # Register GUI update callback
        self._main_frame.after(33, self._redraw_cb)

        # Create simulator thread and a halt and exit event
        self._sim_lock = threading.Lock()
        self._sim_thread_exit = threading.Event()
        self._sim_thread_is_running = threading.Event()
        self._sim_thread = threading.Thread(target=self._sim_thread_loop)

    def run(self):
        """Run main frame's event loop."""
        self._sim_thread_exit.clear()
        self._sim_thread_is_running.set()
        self._sim_thread.start()

        rv = self._main_frame.mainloop()

        self._sim_thread_exit.set()
        self._sim_thread.join()
        return rv

    def _halt_changed(self, *_):
        if self._halt.get() == 0:
            self._sim_thread_is_running.set()
        else:
            self._sim_thread_is_running.clear()

    def _sim_thread_loop(self):
        while not self._sim_thread_exit.is_set():
            if not self._sim_thread_is_running.wait(0.1):
                continue
            try:
                with self._sim_lock:
                    self._sim.step()
            except MachineError as e:
                log.error('Machine error: %s', e)
                self._halt.set(1)

    def _redraw_cb(self):
        self._refresh_screen()
        self._pc_label.set('PC:{0:04X}'.format(self._sim.mpu.pc))

        self._main_frame.after(33, self._redraw_cb)

    def _create_widgets(self):
        # Create and place tool bar
        self._tool_bar = self._create_tool_bar()
        self._tool_bar.grid(row=0, sticky=tk.E + tk.W)

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

    def _reload_rom(self):
        if self._rom_image_fn is None:
            return

        with self._sim_lock:
            self._sim.load_rom(self._rom_image_fn)
            self._sim.reset()

    def _create_tool_bar(self):
        """Create tool bar frame and connect button event handlers."""
        tool_bar = tk.Frame(self._main_frame)

        if self._rom_image_fn is not None:
            reload_b = tk.Button(
                tool_bar, text='Reload ROM', command=self._reload_rom
            )
            reload_b.pack(side='left')

        reset_b = tk.Button(tool_bar, text='Reset', command=self._sim.reset)
        reset_b.pack(side='left')

        pc_l = tk.Label(tool_bar, textvariable=self._pc_label)
        pc_l.pack(side='right')

        halt_cb = tk.Checkbutton(
            tool_bar, text='Halt', variable=self._halt, indicatoron=0,
            padx=5, pady=5,
        )
        halt_cb.pack(side='left')

        step_b = tk.Button(
            tool_bar, text='Step',
            state=tk.DISABLED if self._halt.get() == 0 else tk.NORMAL
        )
        step_b.pack(side='left')
        def update_step_state(*_):
            step_b['state'] = tk.DISABLED if self._halt.get() == 0 else tk.NORMAL
        self._halt.trace('w', update_step_state)
        return tool_bar

def main():
    # Parse command line options
    opts = docopt(__doc__)
    logging.basicConfig(
        level=logging.WARN if opts['--quiet'] else logging.INFO,
        stream=sys.stderr, format='%(name)s: %(message)s'
    )

    # Create simulator
    sim = BuriSim()

    # Read ROM
    sim.load_rom(opts['<rom>'])

    # Reset
    sim.reset()

    # Create gui application and run main loop
    app = BuriApplication(sim, rom_image=opts['<rom>'])
    app.run()

if __name__ == '__main__':
    main()
