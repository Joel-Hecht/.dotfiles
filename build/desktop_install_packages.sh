#!/bin/bash

# get sublime for apt
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | sudo tee /etc/apt/sources.list.d/sublime-text.sources

pkgs=(
	i3-wm i3lock i3blocks suckless-tools # necessary for i3
	xorg-dev libx11-dev libxrandr-dev # x11 support
	wmctrl # target x11 windows by pid
	konsole # backup terminal emulator
	nitrogen # background manager
	compton # allows transparent terminals
	maim # for screenshots
	xclip # clipboard
	xdotool
	xcape # for remapping capslock to escape
	polkitd # polkit for authenticating as root for i3wm
	feh # lightweight image displayer for pope better than eog
	kitty-terminfo # tell nvim about kitty for terminal mode
	notepadqq
	chromium # needed for microsoft crap
)

sudo apt install ${pkgs[@]}

#flatpak setup
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#pinta
flatpak install flathub com.github.PintaProject.Pinta
#discord
flatpak install flathub com.discordapp.Discord
sudo flatpak override com.github.PintaProject.Pinta --filesystem=~/ && echo "pinta permissions added"

# kitty terminal emulator, this is what we use now
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

#install touchegg from source, which may or may not work this time
if [[ -z $(command -v touchegg) ]]; then
	sudo apt install libudev-dev libinput-dev libpugixml-dev libcairo2-dev libx11-dev libxtst-dev libxrandr-dev libxi-dev libglib2.0-dev libgtk-3-dev
	# Clone touchegg
	mkdir -p ~/apps
	git clone https://github.com/JoseExposito/touchegg.git ~/apps/touchegg
	cd ~/apps/touchegg
	# Edit cmake for our real systemd dir before building
	sed -i 's!${SYSTEMD_SERVICE_DIR}!/etc/systemd/system/!' CMakeLists.txt
	mkdir build
	cd build
	cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release ..
	# Make, install, and run touchegg
	make -j$(nproc)
	sudo make install
	sudo systemctl daemon-reload
	sudo systemctl restart touchegg
	touchegg >/dev/null &
fi
