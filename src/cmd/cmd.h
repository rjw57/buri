#ifndef CMD_H
#define CMD_H

void cmd_echo(void);
void cmd_dump(void);

extern char arg1, arg2, arg3;
#pragma zpsym("arg1");
#pragma zpsym("arg2");
#pragma zpsym("arg3");

extern char line_buffer_start;
#define line_buffer (&line_buffer_start)

#endif // CMD_H
