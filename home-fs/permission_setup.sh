#!/bin/bash

bindir=$(dirname $(realpath $0))/bin/

for f in "$bindir"* ; do
	if [ -f f ]; then
		chmod +x f
	fi
done

##make keyboard firmware executable without password for keyboard shortcut
#kf="$bindir"/keyboard_firmware
##make root owner and change setUID so it can exectue without password
#sudo chown root:root "$kf"
#sudo chmod 4755 "$kf"

#give pinta home directory access
sudo flatpak override com.github.PintaProject.Pinta --filesystem=~/ && echo "pinta permissions added"


