#!/bin/bash
thispath=$(realpath $0)
thispath=$(dirname $(dirname "$thispath"))
bindir="$thispath/bin/"

for f in "$bindir"* ; do
	if [ -f f ]; then
		chmod +x f
	fi
done

chmod +x "$HOME/.bash_exit.sh"

##make keyboard firmware executable without password for keyboard shortcut
#kf="$bindir"/keyboard_firmware
##make root owner and change setUID so it can exectue without password
#sudo chown root:root "$kf"
#sudo chmod 4755 "$kf"

#give pinta home directory access
sudo flatpak override com.github.PintaProject.Pinta --filesystem=~/ && echo "pinta permissions added"
