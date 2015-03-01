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

EXE_FILES=helloworld.obj
CLEAN_FILES+=$(EXE_FILES)
CLEAN_FILES+=$(EXE_FILES:.obj=.o)

## cl65 command-line flags

# Use the more modern 65C02
CL65_FLAGS+=--cpu 65C02

# Use optimisation
CL65_FLAGS+=-O

# We are using the "none" target
CL65_FLAGS+=-t none

# Append linker config configuration to cl65 command line
CL65_FLAGS+=-C "$(LINK_CONFIG)"

.PHONY:all
all: $(EXE_FILES)

.PHONY: clean
clean:
	rm -f $(CLEAN_FILES)

%.obj: %.o $(LINK_CONFIG)
	$(CL65) $(CL65_FLAGS) -o "$@" "$<"

%.o: %.s $(LINK_CONFIG)
	$(CL65) $(CL65_FLAGS) -c -o "$@" "$<"
