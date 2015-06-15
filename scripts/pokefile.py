#!/usr/bin/env python
"""
Send files to Búri by directly poke-ing them into memory via the CLI.

Usage:
    pokefile.py [--offset ADDRESS] <file>

Options:
    -h, --help              Show usage summary.
    -o, --offset ADDRESS    Write file starting at ADDRESS. [default: 0x5000]

The ADDRESS can be specified in decimal or hex (starting with '0x' or '$' or
ending with 'h').

Example:
    pokefile.py --offset 0x5000 foo.bin
"""
from __future__ import print_function, division

import sys
import time

import docopt

def parse_num(x):
    if x.startswith('$'):
        return int(x[1:], 16)
    elif x.startswith('0x'):
        return int(x[2:], 16)
    elif x.endswith('h') or x.endswith('H'):
        return int(x[:-1], 16)

    # otherwise, parse as int
    return int(x)

def errprint(*args, **kwargs):
    new_kwargs = {}
    new_kwargs.update(kwargs)
    new_kwargs['file'] = sys.stderr
    print(*args, **new_kwargs) # pylint: disable=star-args

def send_enter():
    """send enter and flush stdout"""
    sys.stdout.write('\x0D') # send carriage return
    sys.stdout.flush()

def wait_star():
    """wait for the star prompt"""
    while True:
        r = sys.stdin.read(1)
        if r == '*':
            break

def main():
    opts = docopt.docopt(__doc__)
    offset = parse_num(opts['--offset'])
    with open(opts['<file>'], 'rb') as f:
        file_contents = f.read()

    # Check file size
    n_bytes = len(file_contents)
    if n_bytes + offset > 0x8000:
        errprint('File too large')
        sys.exit(1)

    errprint('Uploading ${size:X} bytes to ${offset:04X}.'.format(
        size=n_bytes, offset=offset
    ))

    # wait for prompt
    send_enter()
    wait_star()

    then = time.time()
    last_percent = -1
    for n, b in enumerate(file_contents):
        p = int(100*n/n_bytes)
        if last_percent != p:
            sys.stderr.write('{0:02}%\r'.format(p))
            sys.stderr.flush()
            last_percent = p
        cmd = 'poke {0:04x} {1:02x}'.format(n+offset, b)
        sys.stdout.write(cmd)
        send_enter()
        wait_star()
    now = time.time()
    errprint('100%\nFinished. BPS={0}'.format(int(n_bytes / (now-then))))

if __name__ == '__main__':
    main()
