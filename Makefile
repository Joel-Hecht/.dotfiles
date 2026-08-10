.PHONY: all
all:
	./build/install_pkgs.sh
	./build/make_mans.sh
	cd home-fs && make $@

.PHONY: sym
sym:
	cd home-fs && make $@

.PHONY: mans
mans:
	./build/make_mans.sh

.PHONY: font
font:
	cd home-fs && make $@
