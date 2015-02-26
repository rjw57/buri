# If CC65_DIR is set, add ${CC65_DIR}/bin to path
ifdef CC65_DIR
	export PATH := ${CC65_DIR}/bin:$(PATH)
endif

# Define project directory (contains this Makefile) and build directory
# (directory from which make was run).
proj_dir := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
build_dir := $(abspath $(shell pwd))

# Source directory within the project contains the source code itself
src_dir := src

# Source files which make up this project. Use wildcard to avoid having to add
# files explicitly.
ROM_SRCS := \
	$(patsubst $(proj_dir)/%,%,$(wildcard $(proj_dir)/$(src_dir)/*.[cs])) \
	$(patsubst $(proj_dir)/%,%,$(wildcard $(proj_dir)/$(src_dir)/*.inc))

# Config file for linker
LINK_CONFIG := $(proj_dir)/rom.cfg

# cl65 command-line flags
CL65FLAGS += -O

# Location of binaries used by this makefile
CL65       := cl65
MAKEDEPEND := makedepend

# All source files for this project
all_srcs := $(addprefix $(proj_dir)/,$(ROM_SRCS))
c_srcs := $(filter %.c,$(all_srcs))
object_files += $(patsubst %.c,%.o,$(filter %.c,$(ROM_SRCS)))
asm_srcs := $(filter %.s,$(all_srcs))
object_files += $(patsubst %.s,%.o,$(filter %.s,$(ROM_SRCS)))
clean_files += $(object_files)
inc_srcs := $(filter %.inc,$(all_srcs))

# We are using the "none" target
CL65FLAGS += -t none

# Append linker config configuration to cl65 command line
CL65FLAGS += -C "$(LINK_CONFIG)"

# Append include file location to cl65 command line
CL65FLAGS += --asm-include-dir inc

# ROM output
rom_output:=rom.bin
clean_files+=$(rom_output)

# Generate a map file
CL65FLAGS += --mapfile "$(rom_output).map"
clean_files+="$(rom_output).map"

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

$(rom_output): $(object_files) $(LINK_CONFIG)
	$(CL65) $(CL65FLAGS) -o "$@" $(object_files)

$(src_dir)/%.o: $(proj_dir)/$(src_dir)/%.c $(depends_mkfile) $(LINK_CONFIG)
	mkdir -p $(src_dir)
	$(CL65) $(CL65FLAGS) -c -o "$@" "$<"

$(src_dir)/%.o: $(proj_dir)/$(src_dir)/%.s $(inc_srcs) $(LINK_CONFIG)
	mkdir -p $(src_dir)
	$(CL65) $(CL65FLAGS) -c -o "$@" "$<"


# Include generated dependencies
-include $(depends_mkfile)
# DO NOT DELETE
