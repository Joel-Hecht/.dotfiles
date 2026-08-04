#!/bin/bash

# get sublime for apt
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | sudo tee /etc/apt/sources.list.d/sublime-text.sources

sudo apt install \
i3-wm `_necessary for i3`\
i3lock \
i3blocks \
suckless-tools \
xorg-dev libx11-dev libxrandr-dev `_x11 support`  \
konsole `_backup terminal emulator, we dont use this anymore`\
compton `_allows transparent terminals` \
maim `_needed for screenshots` \
xclip \
xdotool \
xcape `_multiple remapping for tap caps lock = escape` \
nitrogen `_desktop background manager` \
polkitd `_polkit needed to authenticate as root from i3wm` \
feh `_lighter weight than eog for pope` \
wmctrl `_to target x11 windows by pid` \
kitty-terminfo `_tells nvim about kitty for terminal mode` \
notepadqq \
chromium `_needed for microsoft crap that doesnt play nice with firefox`

#flatpak setup
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#pinta
flatpak install flathub com.github.PintaProject.Pinta
#discord
flatpak install flathub com.discordapp.Discord

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
