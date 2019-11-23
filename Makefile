SHELL = /bin/bash

prefix ?= /usr/local
bindir ?= $(prefix)/bin
libdir ?= $(prefix)/lib
srcdir = Sources

REPODIR = $(shell pwd)
BUILDDIR = $(REPODIR)/.build
SOURCES = $(wildcard $(srcdir)/**/*.swift)

.DEFAULT_GOAL = all

.PHONY: all
all: sentiment

.PHONY: sentiment
sentiment: $(SOURCES)
	@swift build \
		-c release \
		--disable-sandbox \
		--build-path "$(BUILDDIR)"

.PHONY: install
install: sentiment
	@install -d "$(bindir)" "$(libdir)"
	@install "$(BUILDDIR)/release/sentiment" "$(bindir)"

.PHONY: uninstall
uninstall:
	@rm -rf "$(bindir)/sentiment"

.PHONY: clean
distclean:
	@rm -rf $(BUILDDIR)/release

.PHONY: clean
clean: distclean
	@rm -rf $(BUILDDIR)
