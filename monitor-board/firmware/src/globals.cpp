#include "globals.h"

unsigned int address_bus;
byte data_bus;
byte status_bits;
bool halt;
StepState step_state;
bool pull_rst_low;
bool pull_be_low;
