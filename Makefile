# Source files which make up this project
ROM_SRCS := main.c vectors.asm

# Config file for linker
LINK_CONFIG := mk1.cfg

# Location of binaries used by this makefile
CL65       := cl65
MAKEDEPEND := makedepend

# Define source directory (one containing Makefile) and build directory (one
# make is run from).
src_dir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
build_dir := $(abspath $(shell pwd))

# All source files for this project
all_srcs := $(addprefix $(src_dir)/,$(ROM_SRCS))
c_srcs := $(filter %.c,$(all_srcs))
object_files += $(patsubst %.c,%.o,$(filter %.c,$(ROM_SRCS)))
asm_srcs := $(filter %.asm,$(all_srcs))
object_files += $(patsubst %.asm,%.o,$(filter %.asm,$(ROM_SRCS)))
clean_files += $(object_files)

# Append linker config configuration to cl65 command line
CL65FLAGS += -C "$(src_dir)/$(LINK_CONFIG)"

# ROM output
rom_output:=rom.bin
clean_files+=$(rom_output) $(patsubst %.bin,%,$(rom_output))

all: $(rom_output)
.PHONY: all

# Calculate dependencies for C files
depends_mkfile:=Makefile.depends
clean_files+=$(depends_mkfile) $(depends_mkfile).bak
$(depends_mkfile): $(c_srcs)
	touch $(depends_mkfile)
	$(MAKEDEPEND) -f "$@" -- $(c_srcs)

depends: $(depends_mkfile)
.PHONY: depends

clean:
	rm -f $(clean_files)
.PHONY: clean

$(rom_output): $(object_files) $(src_dir)/$(LINK_CONFIG)
	$(CL65) $(CL65FLAGS) -o "$(patsubst %.bin,%,$@)" $(object_files)

%.o: $(src_dir)/%.c $(depends_mkfile) $(src_dir)/$(LINK_CONFIG)
	$(CL65) $(CL65FLAGS) -c -o "$@" "$<"

%.o: $(src_dir)/%.asm $(src_dir)/$(LINK_CONFIG)
	$(CL65) $(CL65FLAGS) -c -o "$@" "$<"


# Include generated dependencies
-include $(depends_mkfile)
