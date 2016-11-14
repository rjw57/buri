#include "hw/vdp.h"

static const char msg[] = "Buri Microcomputer System";

#define VDP_NAME_BASE 0x0800

typedef struct {
	u8 col, row;
	u16 offset;
} console_state_t;

#define CONSOLE_COLS 40
#define CONSOLE_ROWS 24

static console_state_t g_console_state;

static console_set_pos(u8 col, u8 row) {
	col = col > CONSOLE_COLS-1 ? CONSOLE_COLS-1 : col;
	row = row > CONSOLE_ROWS-1 ? CONSOLE_ROWS-1 : row;
	g_console_state.col = col;
	g_console_state.row = row;
	g_console_state.offset = VDP_NAME_BASE | (col + row * CONSOLE_COLS);
}

static console_scroll_up() {
	int i, j, end;

	end = VDP_NAME_BASE + CONSOLE_COLS * (CONSOLE_ROWS - 1);
	i = VDP_NAME_BASE;
	j = i + CONSOLE_COLS;

	for(; i < end; ++i, ++j) {
		u8 v;
		vdp_write_ctrl(j & 0xff);
		vdp_write_ctrl((j >> 8) & 0x3f);
		v = vdp_read_data();
		vdp_write_ctrl(i & 0xff);
		vdp_write_ctrl((i >> 8) & 0x3f);
		vdp_write_data(v);
	}
}

static console_put_char(u8 c) {
	vdp_write_ctrl(g_console_state.offset & 0xff);
	vdp_write_ctrl(0x40 | ((g_console_state.offset >> 8) & 0x3f));
	vdp_write_data(c);

	if(g_console_state.col < CONSOLE_COLS-1) {
		++g_console_state.col;
		++g_console_state.offset;
	} else if(g_console_state.row < CONSOLE_ROWS-1) {
		g_console_state.col = 0;
		++g_console_state.row;
		++g_console_state.offset;
	} else {
		g_console_state.row = g_console_state.col = 0;
		g_console_state.offset = VDP_NAME_BASE;
	}
}

static void puts(const char* s) {
	for(; *s != '\0'; ++s) {
		console_put_char(*s);
	}
}

void start(void) {
	vdp_init();

	console_set_pos(0, 0);

	while(1) {
		puts(msg);
		puts(" ");
	}
}
