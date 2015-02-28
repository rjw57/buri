# If CC65_DIR is set, add ${CC65_DIR}/bin to path
ifdef CC65_DIR
	export PATH := ${CC65_DIR}/bin:$(PATH)
endif

# Directories
ASMINC_DIR:=asminc
HDR_DIR:=include
SRC_DIR:=src

# Find the cl65 tool if not specified
CL65?=$(shell PATH="$(PATH)" which cl65)
ifeq ($(CL65),)
$(error The cl65 tool was not found. Try setting the CC65_DIR variable.)
endif

# Source files which make up this project
ROM_SRCS+=$(wildcard $(ASMINC_DIR)/*.inc)
ROM_SRCS+=$(wildcard $(HDR_DIR)/*.h)
ROM_SRCS+=\
	$(wildcard $(SRC_DIR)/common/*.[cs])	\
	$(wildcard $(SRC_DIR)/serial/*.[cs])	\
	$(wildcard $(SRC_DIR)/vt100/*.[cs])	\
	$(wildcard $(SRC_DIR)/cli/*.[cs])	\
	$(wildcard $(SRC_DIR)/io/*.[cs])	\
	$(wildcard $(SRC_DIR)/*.[cs])

# Convert sources into list of object files
OBJECTS+=$(patsubst %.c,%.o,$(filter %.c,$(ROM_SRCS)))
OBJECTS+=$(patsubst %.s,%.o,$(filter %.s,$(ROM_SRCS)))
CLEAN_FILES+=$(OBJECTS)

# List of various include-type files
INC_FILES=$(filter %.inc,$(ROM_SRCS))
HDR_FILES=$(filter %.h,$(ROM_SRCS))

# Config file for linker
LINK_CONFIG := rom.cfg

## cl65 command-line flags

# Use the more modern 65C02
CL65_FLAGS+=--cpu 65C02

# Use optimisation
CL65_FLAGS+=-O

# We are using the "none" target
CL65_FLAGS+=-t none

# Append linker config configuration to cl65 command line
CL65_FLAGS+=-C "$(LINK_CONFIG)"

# Append include file locations to cl65 command line
CL65_FLAGS+=--asm-include-dir $(ASMINC_DIR) -I $(HDR_DIR)

# ROM output
ROM_BIN:=rom.bin
CLEAN_FILES+=$(ROM_BIN)

# Generate a map file
CL65_FLAGS+= --mapfile "$(ROM_BIN).map"
CLEAN_FILES+="$(ROM_BIN).map"

.PHONY: all
all: $(ROM_BIN)

.PHONY: clean
clean:
	rm -f $(CLEAN_FILES)

$(ROM_BIN): $(OBJECTS) $(LINK_CONFIG)
	$(CL65) $(CL65_FLAGS) -o "$@" $(OBJECTS)

$(SRC_DIR)/%.o: $(SRC_DIR)/%.c $(HDR_FILES) $(LINK_CONFIG)
	$(CL65) $(CL65_FLAGS) -c -o "$@" "$<"

$(SRC_DIR)/%.o: $(SRC_DIR)/%.s $(INC_FILES) $(LINK_CONFIG)
	$(CL65) $(CL65_FLAGS) -c -o "$@" "$<"
