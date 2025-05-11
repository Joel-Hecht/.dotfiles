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
gcc make cmake vim neovim  `general tools` \
fdisk `volume viwer thats worst than lsblk but i like it`\
git gh `if you got this far you should already have this` \
libx11-dev `x11 support, needed for multi-monitor config` \
calcurse `in-terminal calendar` 


#flatpaks
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.github.PintaProject.Pinta `pinta`
