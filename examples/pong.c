#define VIA1 ((volatile unsigned char*)0xDFE0)
#define VIA1_DDRB VIA1
#define VIA1_ORB (VIA1+2)

#define MC6845_AR       ((volatile unsigned char*)0xDFFA)
#define MC6845_DR       ((volatile unsigned char*)0xDFFB)

#define HORIZ_TOT       0x00
#define HORIZ_DISP      0x01
#define HORIZ_SYNCP     0x02
#define SYNC_WIDTH      0x03
#define VERT_TOT        0x04
#define VERT_TOT_ADJ    0x05
#define VERT_DISP       0x06
#define VERT_SYNCP      0x07
#define INTLACE_SKEW    0x08
#define MAX_RAST        0x09
#define CSR_START       0x0A
#define CSR_END         0x0B
#define START_ADDR_H    0x0C
#define START_ADDR_L    0x0D
#define CURSOR_H        0x0E
#define CURSOR_L        0x0F
#define LIGHTPEN_H      0x10
#define LIGHTPEN_L      0x11

void set_reg(unsigned char num, unsigned char val) {
    *MC6845_AR = num;
    *MC6845_DR = val;
}

void main(void) {
    int w = 76, h = 60;
    int x = 0, y = 0;
    int dx = 1, dy = 1;

    /* low horiz res. */
    /*
    set_reg(HORIZ_TOT, 48-1);
    set_reg(HORIZ_DISP, 38);
    set_reg(HORIZ_SYNCP, 40-1);
    set_reg(SYNC_WIDTH, 0x26);
    */

    /* high horiz res. */
    set_reg(HORIZ_TOT, 96-1);
    set_reg(HORIZ_DISP, 76);
    set_reg(HORIZ_SYNCP, 80-1);
    set_reg(SYNC_WIDTH, 0x2B);

    set_reg(VERT_TOT, 65-1);
    set_reg(VERT_TOT_ADJ, 1);
    set_reg(VERT_DISP, 60);
    set_reg(VERT_SYNCP, 62-1);
    set_reg(INTLACE_SKEW, 0);
    set_reg(MAX_RAST, 7);

    /* flashing cursor */
    /*
    set_reg(CSR_START, 0x66);
    set_reg(CSR_END, 0x07);
    */

    /* solid cursor */
    set_reg(CSR_START, 0x00);
    set_reg(CSR_END, 0x07);

    set_reg(START_ADDR_H, 0x00);
    set_reg(START_ADDR_L, 0x00);
    set_reg(CURSOR_H, 0x00);
    set_reg(CURSOR_L, 0x00);

    /* pong! */
    *VIA1_DDRB = 0xFF;
    for(;;) {
        unsigned int d = 0, cpos;
        unsigned char s = 0;

        x += dx; y += dy;
        if(x >= w) { x = w-1; dx *= -1; s |= 1; }
        if(y >= h) { y = h-1; dy *= -1; s |= 2; }
        if(x < 0) { x = 0; dx *= -1; s |= 1; }
        if(y < 0) { y = 0; dy *= -1; s |= 2; }

        cpos = x + (y * w);

        set_reg(CURSOR_H, cpos>>8);
        set_reg(CURSOR_L, cpos&0xFF);

        *VIA1_ORB = s;
        for(d=0; d<1000; ++d) { }
        *VIA1_ORB = 0x00;
    }
}

/*
 vim:sw=4:sts=4:et
 */
