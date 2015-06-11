# Find the jekyll tool if not specified
JEKYLL?=$(shell PATH="$(PATH)" which jekyll)
ifeq ($(JEKYLL),)
$(error Jekyll executable was not found. Install it or specify location via JEKYLL variable.)
endif

docs:
	$(JEKYLL) build
serve:
	$(JEKYLL) serve

.PHONY: docs serve
