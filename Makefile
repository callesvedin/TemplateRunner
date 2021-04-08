prefix ?= /usr/local
bindir = $(prefix)/bin

build:
	swift build -c release --disable-sandbox

install: build
	install ".build/release/TemplateRunner" "$(bindir)/TemplateRunner"	

uninstall:
	rm -rf "$(bindir)/TemplateRunner"	

clean:
	rm -rf .build

.PHONY: build install uninstall clean
