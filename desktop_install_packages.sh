#!/bin/bash

# get sublime for apt
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | sudo tee /etc/apt/sources.list.d/sublime-text.sources

sudo apt install \
i3-wm `_necessary for i3`\
i3lock \
i3blocks \
suckless-tools \
konsole `_my preferred terminal emulator`\
compton `_allows transparent terminals` \
maim `_needed for screenshots` \
xclip \
xdotool \
nitrogen `_desktop background manager` \
libx11-dev `_x11 support, needed for multi-monitor config` \
policykit-1-gnome polkitd `_polkit needed to authenticate as root from i3wm` \
feh `_lighter weight than eog for pope` \
wmctrl `_to target x11 windows by pid` \

#flatpak setup
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#pinta
flatpak install flathub com.github.PintaProject.Pinta
#discord
flatpak install flathub com.discordapp.Discord

dotdir=$(dirname $(realpath "$0"))
cd $dotdir
./build_kitty_source.sh

# set color temperature (nightlight)
if [[ -z $(command -v xsct) ]]; then 
	git clone https://github.com/faf0/sct.git
	cd sct
	sudo make install
	cd ..
	rm -rf sct
fi
