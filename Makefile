.PHONY: all
all:
	./install_pkgs.sh
#	./home-fs/makealiases.sh
#	./home-fs/makesymlinks.sh
#	source ./home-fs/.bashrc
	cd home-fs && make $@

.PHONY: sym 
sym:
	cd home-fs && make $@
