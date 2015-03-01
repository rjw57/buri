# If CC65_DIR is set, add ${CC65_DIR}/bin to path
ifdef CC65_DIR
	export PATH := ${CC65_DIR}/bin:$(PATH)
endif

# Find the cl65 tool if not specified
CL65?=$(shell PATH="$(PATH)" which cl65)
ifeq ($(CL65),)
$(error The cl65 tool was not found. Try setting the CC65_DIR variable.)
endif

LINK_CONFIG := buri.cfg

ASM_SOURCES:=$(wildcard *.s)
C_SOURCES:=$(wildcard *.c)

ASM_OBJECTS:=$(ASM_SOURCES:.s=.o)
C_OBJECTS:=$(C_SOURCES:.c=.o)
CLEAN_FILES+=$(ASM_OBJECTS) $(C_OBJECTS)

ASM_BINS:=$(ASM_SOURCES:.s=.bin)
C_BINS:=$(C_SOURCES:.c=.bin)
EXE_FILES=$(ASM_BINS) $(C_BINS)
CLEAN_FILES+=$(EXE_FILES)

## cl65 command-line flags

# Use the more modern 65C02
CL65_FLAGS+=--cpu 65C02

# Use optimisation
CL65_FLAGS+=-O

# We are using the "buri" target
CL65_FLAGS+=-t buri

# Append linker config configuration to cl65 command line
CL65_FLAGS+=-C "$(LINK_CONFIG)"

.PHONY:all
all: $(EXE_FILES)

.PHONY: clean
clean:
	rm -f $(CLEAN_FILES)

%.bin: %.o $(LINK_CONFIG)
	$(CL65) $(CL65_FLAGS) -o "$@" "$<"

$(ASM_OBJECTS):%.o: %.s $(LINK_CONFIG)
	$(CL65) $(CL65_FLAGS) -c -o "$@" "$<"

$(C_OBJECTS):%.o: %.c $(LINK_CONFIG)
	$(CL65) $(CL65_FLAGS) -c -o "$@" "$<"
