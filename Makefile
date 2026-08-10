.PHONY: all
all:
	./build/install_pkgs.sh
	./build/makemans.sh
	cd home-fs && make $@

.PHONY: sym
sym:
	cd home-fs && make $@

.PHONY: mans
mans:
	./build/makemans.sh

.PHONY: font
font:
	cd home-fs && make $@
