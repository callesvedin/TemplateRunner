prefix ?= /usr/local
bindir = $(prefix)/bin

build:
	swift build -c release --disable-sandbox

install: build
	install ".build/release/template-runner" "$(bindir)"	

uninstall:
	rm -rf "$(bindir)/template-runner"	

clean:
	rm -rf .build

.PHONY: build install uninstall clean
