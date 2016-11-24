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

#include "../util.h"

#define STX 0x02
#define ACK 0x06

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
    u8 sum1 = 0, sum2 = 0, v;
    u16 dest = parse_hex_16(cli_buf + cli_arg_offsets[0]);
    u16 len = 0, n;

    // wait for STX
    while((len = read()) != STX) { }
    len = read();
    len |= ((u16)read()) << 8;

    // read blocks
    for(n=0; n<len; ++n) {
        if((n & 0xFF) == 0) {
            write(ACK); write(sum1); write(sum2);
        }
        v = read();
        ((u8*)dest)[n] = v;
        sum1 += v;
        sum2 += sum1;
    }

    write(ACK);
    write(sum1); write(sum2);
}
