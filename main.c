#pragma code-name ("ROCODE")

// Entry point to the ROM. This is the "reset" handler.
void reset(void)
{
	// The reset vector never exits
	for(;;) { }
}

