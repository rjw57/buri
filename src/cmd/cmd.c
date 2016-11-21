#include "cmd.h"
#include "commands.h"
#include "util.h"
#include "../cli.h"
#include "../io.h"

void process_cli_cmd(void) {
    if(streq(cli_buf, "help")) {
        putln("You need somebody");
    } else if(streq(cli_buf, "dump")) {
        dump();
    } else if(streq(cli_buf, "wdump")) {
        wdump();
    }
}


