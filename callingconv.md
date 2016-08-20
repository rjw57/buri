# Calling convention

This document holds some notes on the calling convention used within the Búri
OS. Unless otherwise indicated in the comments for a procedure, on entry:

1. The M and X flags are 0 (i.e. 16-bit accumulator and index).
2. The first three 16 or 8-bit parameters are passed in the A, X and Y
   registers.
3. 24-bit and subsequent paramters are passed on the stack.
4. 16-bit return value is passed in A.

On exit,

1. X and Y registers are preserved. A may be corrupted.
2. Z, C, N or V flags may be corrupted or, rarely, used to indicate return
   value.
