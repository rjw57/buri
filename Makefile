.PHONY: all
all: os examples

.PHONY: os
os:
	$(MAKE) -C os/

.PHONY: examples
examples:
	$(MAKE) -C examples/
