// Simple receive command
//
// Syntax: recv <destination>
//
// The recv command will bytes commands read from the serial port to memory
// address <destination> until <length> bytes have been read. It then outputs
// the 16-bit Fletcher checksum of the received bytes as two bytes along the
// serial port. The first byte written is the modulus 256 check sum of received
// bytes and the second byte is the modulus 256 checksum of the checksums.

#include "types.h"

#include "../hw/acia6551.h"
#include "../cli.h"
#include "../io.h"

#include "util.h"

static u8 read(void) {
    i16 v = -1;
    while(v < 0) { v = acia6551_recv_byte(); }
    return v;
}

static void write(u8 v) {
    while(!acia6551_send_byte(v)) { }
}

void recv(void) {
    u8 *ptr;
    u8 sum1 = 0, sum2 = 0;
    u16 dest = parse_hex_16(cli_buf + cli_arg_offsets[0]);
    u16 len = 0;

    // wait for STX
    while((len = read()) != 0x02) { }
    putln("starting...");

    len = read();
    len |= ((u16)read()) << 8;
    puts("length: ");
    put_hex_16(len);
    putln("");

    for(ptr=(u8*)dest; len>0; --len, ++ptr) {
        u8 v = read();
        sum1 += v;
        sum2 += sum1;
        // *ptr = v;
    }

    write(sum1); write(sum2);
}
