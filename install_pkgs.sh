#!/bin/bash

#packages installed with apt (run first)
sudo apt update
sudo apt upgrade -y
sudo apt install \
i3-wm `necessary for i3`\
i3lock \
i3blocks \
suckless-tools \
fonts-jetbrains-mono `fonts`\
fonts-font-awesome \
fonts-powerline \
konsole `my preferred terminal emulator`\
compton `allows transparent terminals` \
maim `needed for screenshots` \
xclip \
xdotool \
nitrogen `desktop background manager` \
wget sed grep `cant believe this isnt default`\
gcc make cmake vim ripgrep  `general tools` \
fdisk `volume viwer thats worst than lsblk but i like it`\
git gh `if you got this far you should already have this` \
libx11-dev `x11 support, needed for multi-monitor config` \
calcurse `in-terminal calendar` \
policykit-1-gnome polkitd `polkit needed to authenticate as root from i3wm` \
vim-gtk3 `install graphical vim, installation gives vim access to system clipboard register`\
python3-venv pip `needed to use pip`\
kitty `new termianl emulator` \
lua5.4 `lua language` \
ninja-build gettext cmake unzip curl `tools we need for later to install neovim` \

#flatpaks
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.github.PintaProject.Pinta `pinta`


#rust stuff
if ! [ -d ~/.cargo ]; then 
	sudo apt install cargo 
	sudo apt autoremove rustc
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

#lean stuff
lean --version || wget -q https://raw.githubusercontent.com/leanprover-community/mathlib4/master/scripts/install_debian.sh && bash install_debian.sh ; rm -f install_debian.sh && source ~/.profile

#actual rustup isntalls
rustup defualt 1.7.0
rustup target add wasm32-unknown-unknown

#neovim version 0.8 isnt in apt
#we need to build from source
#Solution from https://www.reddit.com/r/debian/comments/188d3wc/neovim_on_debian/ 

#here I should check if neovim exists or if the version is less than 0.9.0
nvim_version=$(nvim --version | head -1 | sed "s/[^\.]*\.//" | sed "s/\..*//")
if [[ $nvim_version -lt 9 ||  -z $(command -v nvim)  ]]; then
	sudo apt remove neovim
	currentdir = $(pwd)
	mkdir -p "${HOME}/apps"
	cd "${HOME}/apps"
	git clone https://github.com/neovim/neovim
	cd neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	cd build
	cpack -G DEB
	sudo dpkg -i --force-overwrite  nvim-linux*.deb
	cd "$currentdir"
else
	echo "latest neovim already installed"	
fi
