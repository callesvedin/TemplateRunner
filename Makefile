prefix ?= /usr/local
bindir = $(prefix)/bin

build:
	swift build -c release --disable-sandbox

install: build
	install ".build/release/TemplateRunner" "$(bindir)"	

uninstall:
	rm -rf "$(bindir)/templaterunner"	

clean:
	rm -rf .build

.PHONY: build install uninstall clean
