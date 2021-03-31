prefix ?= /usr/local
bindir = $(prefix)/bin

build:
	swift build -c release --disable-sandbox

install: build
	install ".build/release/TemplateRunner" "$(bindir)/template-runner"	

uninstall:
	rm -rf "$(bindir)/template-runner"	

clean:
	rm -rf .build

.PHONY: build install uninstall clean