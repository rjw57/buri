# If CC65_DIR is set, add ${CC65_DIR}/bin to path
ifdef CC65_DIR
	export PATH := ${CC65_DIR}/bin:$(PATH)
endif

# Directories
INCLUDE_DIR:=src/include
HDR_DIR:=$(INCLUDE_DIR)
ASMINC_DIR:=$(INCLUDE_DIR)
C_RUNTIME_DIR:=c_runtime
SRC_DIR:=src

# Find the cl65 tool if not specified
CL65?=$(shell PATH="$(PATH)" which cl65)
ifeq ($(CL65),)
$(error The cl65 tool was not found. Try setting the CC65_DIR variable.)
endif

# Find the ar65 tool if not specified
AR65?=$(shell PATH="$(PATH)" which ar65)
ifeq ($(AR65),)
$(error The ar65 tool was not found. Try setting the CC65_DIR variable.)
endif

# Source files which make up this project
ROM_SRCS+=$(wildcard $(ASMINC_DIR)/*.inc)
ROM_SRCS+=$(wildcard $(HDR_DIR)/*.h)
ROM_SRCS+=\
	$(wildcard $(SRC_DIR)/*/*.[cs])	\
	$(wildcard $(SRC_DIR)/*.[cs])
C_RUNTIME_SRCS+=$(wildcard $(C_RUNTIME_DIR)/*.s)

# Convert sources into list of object files
OBJECTS+=$(patsubst %.c,%.o,$(filter %.c,$(ROM_SRCS)))
OBJECTS+=$(patsubst %.s,%.o,$(filter %.s,$(ROM_SRCS)))
C_RUNTIME_OBJECTS+=$(patsubst %.s,%.o,$(filter %.s,$(C_RUNTIME_SRCS)))
CLEAN_FILES+=$(OBJECTS) $(C_RUNTIME_OBJECTS)

# List of various include-type files
INC_FILES=$(filter %.inc,$(ROM_SRCS))
HDR_FILES=$(filter %.h,$(ROM_SRCS))

# Config file for linker
LINK_CONFIG := rom.cfg

## cl65 command-line flags

# Use 65816 instruction set
CL65_FLAGS+=--cpu 65816

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
CLEAN_FILES+=$(ROM_BIN) $(ROM_BIN).hex

# C runtime library output
CRT_LIB:=crt.lib
CLEAN_FILES+=$(CRT_LIB)

# Generate a map file
CL65_FLAGS+= --mapfile "$(ROM_BIN).map"
CLEAN_FILES+="$(ROM_BIN).map"

.PHONY: all
all: $(ROM_BIN) $(ROM_BIN).hex

.PHONY: clean
clean:
	rm -f $(CLEAN_FILES)

$(ROM_BIN): $(OBJECTS) $(CRT_LIB) $(LINK_CONFIG)
	$(CL65) $(CL65_FLAGS) -o "$@" $(OBJECTS) crt.lib

$(CRT_LIB): $(C_RUNTIME_OBJECTS)
	rm -f "$(CRT_LIB)"
	$(AR65) a "$(CRT_LIB)" $(C_RUNTIME_OBJECTS)

$(C_RUNTIME_DIR)/%.o: $(C_RUNTIME_DIR)/%.s $(LINK_CONFIG)
	$(CL65) $(CL65_FLAGS) -c -o "$@" "$<"

$(SRC_DIR)/%.o: $(SRC_DIR)/%.c $(HDR_FILES) $(LINK_CONFIG)
	$(CL65) $(CL65_FLAGS) -c -o "$@" "$<"

$(SRC_DIR)/%.s: $(SRC_DIR)/%.c $(HDR_FILES) $(LINK_CONFIG)
	$(CL65) $(CL65_FLAGS) -S -o "$@" "$<"

$(SRC_DIR)/%.o: $(SRC_DIR)/%.s $(INC_FILES) $(LINK_CONFIG)
	$(CL65) $(CL65_FLAGS) -c -o "$@" "$<"

%.hex: %
	hexdump -C "$<" >"$@"
