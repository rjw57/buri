.include "macros.inc"
.import _cmd_echo, _cmd_dump

.importzp arg1, arg2, arg3
.exportzp _arg1, _arg2, _arg3

.import line_buffer
.export _line_buffer_start

_arg1 = arg1
_arg2 = arg2
_arg3 = arg3
_line_buffer_start = line_buffer

registercmd "echo", _cmd_echo
registercmd "dump", _cmd_dump
