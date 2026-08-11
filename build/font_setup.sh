#!/bin/bash
mkdir -p ~/.local/share/fonts

cd ~/.local/share/fonts
#download JetBrainsMono Nerd Font
fname="JetBrainsMono.zip"
curl -fLO  "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip" -o "$fname"
unzip "$fname" -d ~/.local/share/fonts/jetbrains-mono

#refresh font cache to allow i3 to detect nerd fonts
fc-cache -fv
