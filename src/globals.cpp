#include "globals.h"

unsigned int address_bus;
byte data_bus;
byte status_bits;
bool halt_request;
bool cycle_request;
bool skip_to_next_sync;
