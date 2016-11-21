#include "util.h"
#include "commands.h"
#include "../cli.h"
#include "../io.h"

// The iomask command directly manuipulates the I/O mask. See io.h for mask bit
// constants. It takes two arguments. Bits set in the first argument will be set
// in the I/O mask. Bits set in the second argument will be *cleared* in the I/O
// mask.

void iomask(void) {
    io_mask |= parse_hex_8(cli_buf + cli_arg_offsets[0]);
    io_mask &= ~(parse_hex_8(cli_buf + cli_arg_offsets[1]));
}

