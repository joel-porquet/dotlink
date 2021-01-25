DESTDIR ?=

PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin

all:
	@echo "dotlink is a shell script, nothing to compile here."
	@echo "Try 'make install' instead."

install:
	@install -v -d "$(DESTDIR)$(BINDIR)"
	@install -m 0755 -v dotlink "$(DESTDIR)$(BINDIR)/dotlink"

uninstall:
	@rm -vrf \
		"$(DESTDIR)$(BINDIR)/dotlink"

.PHONY: install uninstall
