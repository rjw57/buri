// MAX7219 registers.
#define MX7219_NOP          0x0
#define MX7219_DIGIT_0      0x1
#define MX7219_DECODE_MODE  0x9
#define MX7219_INTENSITY    0xA
#define MX7219_SCN_LIMIT    0xB
#define MX7219_SHUTDOWN     0xC
#define MX7219_DPLY_TEST    0xF

// A simple font for the MAX7219. Bits, MSB to LSB, correspond to segments DP,
// A, B, C, D, E, F and G with the following arrangement:
//
//       ___
//        A
//   F | ___ | B
//        G
//   E | ___ | C
//        D       . DP
//
byte MX7219_FONT[] = {
    // 0-9
    0x7E, 0x30, 0x6D, 0x79, 0x33, 0x5B, 0x5F, 0x70, 0x7F, 0x7B,

    // A-F
    0x77, 0x1F, 0x4E, 0x3D, 0x4F, 0x47,

    // H, L, n, o, P, r, S, t, u, Y
    0x37, 0x0E, 0x15, 0x1D, 0x67, 0x05, 0x5B, 0x0F, 0x1C, 0x3B,

    // Space
    0x00,

    // Individual segments
    0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01, 0x00,
};

#define MX7219_FONT_N_CHARS (sizeof(MX7219_FONT)/sizeof(byte))
