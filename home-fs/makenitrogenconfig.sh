#!/bin/bash

symtofile() {
	if [[ -L ~/.config/nitrogen/$1 ]]; then
		rm ~/.config/nitrogen/$1
	fi
	if [[ ! -e ~/.config/nitrogen/$1 ]]; then
		cp ~/.dotfiles/home-fs/.config/nitrogen/$1 ~/.config/nitrogen/$1
	fi
}

if [[ ! -d ~/.config/nitrogen/ ]]; then
	mkdir ~/.config/nitrogen/
fi

# if symlink converts to regular, if doesn't exist copies over, if exists does nothing
symtofile "bg-saved.cfg"
symtofile "nitrogen.cfg"
