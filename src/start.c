#include "types.h"

#include "hw/acia6551.h"
#include "hw/keyboard.h"
#include "hw/vdp.h"
#include "hw/ym3812.h"

#include "cmd/cmd.h"

#include "console.h"
#include "cli.h"
#include "io.h"

static void process_cli(void);
static void print_banner(void);

void start(void) {
    int i = 0;
    i16 v = 0;

    // init hardware
    acia6551_init();
    keyboard_init();
    vdp_init();
    ym3812_init();

    // init higher-level drivers
    console_init();

    print_banner();

    cli_start();
    while(1) {
        console_idle();
        v = getc();
        if(v < 0) { continue; }
        if(cli_new_char((u8)v)) {
            process_cli_cmd();
            cli_start();
        }
    }
}

static void print_banner(void) {
    static const char msg[] = "Buri Microcomputer System";
    putln(msg);
    putln("");
}
