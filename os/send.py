#!/usr/bin/env python3
#
# Simple helper for use with picocom & recv.
import sys
import tqdm

STX = 0x02
ACK = 0x06

def log(s):
    print(s, file=sys.stderr)

with open(sys.argv[1], 'rb') as fobj:
    data = fobj.read()

data_len = len(data)
hdr = bytes([STX, data_len & 0xFF, (data_len >> 8) & 0xFF])
sys.stdout.buffer.write(hdr)
sys.stdout.flush()

sum1, sum2 = 0, 0
for idx in tqdm.tqdm(range(0, data_len, 256)):
    while sys.stdin.buffer.read(1) != bytes([ACK]):
        pass
    csum = sys.stdin.buffer.read(2)
    assert csum[0] == sum1
    assert csum[1] == sum2
    chunk = data[idx:idx+256]
    sys.stdout.buffer.write(chunk)
    sys.stdout.flush()

    for b in chunk:
        sum1 = (sum1 + b) % 256
        sum2 = (sum2 + sum1) % 256

while sys.stdin.buffer.read(1) != bytes([ACK]):
    pass
csum = sys.stdin.buffer.read(2)
assert csum[0] == sum1
assert csum[1] == sum2
