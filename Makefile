# Source files which make up this project
ASM_SOURCES:=\
	tight-loop.asm

# Output file
OUTPUT:=rom.bin

# Config file for linker
LINK_CONFIG:=mk1.cfg

# Location of cc65 binaries
CA65:=ca65
LD65:=ld65

# Define source and build directories
src_dir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
build_dir := $(abspath $(shell pwd))

# Output object files
objects:=$(ASM_SOURCES:.asm=.o)

all: $(OUTPUT)
.PHONY: all

clean:
	rm -f $(objects)
	rm -f $(OUTPUT)
.PHONY: clean

$(OUTPUT): $(objects) $(src_dir)/$(LINK_CONFIG)
	$(LD65) -o "$(@:.bin=)" --config "$(src_dir)/$(LINK_CONFIG)" $(objects)

%.o: $(src_dir)/%.asm
	$(CA65) -o "$@" "$<"
