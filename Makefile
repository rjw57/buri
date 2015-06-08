.PHONY: all
all: os examples

.PHONY: os
os:
	$(MAKE) -C os/

.PHONY: examples
examples:
	$(MAKE) -C examples/

.PHONY: docs
docs:
	$(MAKE) -C docs/

.PHONY: clean
clean:
	$(MAKE) -C os/ clean
	$(MAKE) -C examples/ clean
