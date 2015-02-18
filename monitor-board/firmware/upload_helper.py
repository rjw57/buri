#!/usr/bin/env python
"""
A little helper script to upload a binary file.

Usage:
    upload_helper.py <file>

Writes hex representation of file 16 bytes per line pausing between lines.
"""

from __future__ import print_function

import sys
import time

def main():
    with open(sys.argv[1], 'rb') as f:
        n = 0
        while True:
            bs = f.read(48)
            if len(bs) == 0:
                break
            n += len(bs)

            print(bs.encode('hex'))
            sys.stdout.flush()
            while sys.stdin.read(1) != ':':
                # spin
                pass

            sys.stderr.write('{0:04X} '.format(n))
            sys.stderr.flush()
    print('')

if __name__ == '__main__':
    main()
