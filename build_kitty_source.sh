#!/bin/bash

#determine if we need to install kitty

install=0
if [[ -z $(command -v kitty) ]]; then
	#if not kitty exists, isntall here
	install=1
	echo "no kitty installation found, installing now"
else	
	#we need to build kitty terminal from source 
	kitty_version=$(kitty -v | grep -o " [0-9]*\.[0-9]*\.[0-9]* ")
	kitty_is_unstable=0
	kitty_unstable_pattern="0\..*"
	if [[ "$kitty_version" =~ $kitty_unstable_pattern ]]; then
		kitty_is_unstable=1
	fi
	
	kitty_minor_version=$(echo "$kitty_version"| grep -o "\.[0-9]*\." | sed "s/\.//g")
	
	#if we are on an unstable release below 44
	if [[ $kitty_is_unstable -eq 1 && $kitty_minor_version -lt 43 ]]; then
		echo "Out of date kitty $kitty_version found, updating now"
		install=1	
	else 
		echo "kitty already installed as version $kitty_version"
	fi
fi 

if [[ $install -eq 0 ]]; then
	#if we shouldnt install, exit here
	exit 0
fi

curr="$(pwd)"

#clear if exists
installdir="${HOME}/.kitty"
rm -rf "$installdir"
mkdir -p "$installdir"
cd "$installdir"

#install go 1.25
#debian only supports up to 1.19, which is not sufficient
goversion="1.25.5"
tarball="go${goversion}.linux-amd64.tar.gz"
curl -L https://go.dev/dl/"$tarball" -o "$tarball"
sudo rm -rf /usr/local/go
sudo rm -rf /usr/bin/go
sudo tar -C /usr/local -xzf "$tarball" && echo "Installed go ${goversion}"
rm "$tarball" #clean up

#go is already added to PATH in bashrc
source ~/.bashrc

#install deps not from install_packages (mesa is large, so we will remove after)
deps=("libx11-xcb-dev" "libxcb-xkb-dev" "xorg-dev" "libgl1-mesa-dev" "libdbus-1-dev")
sudo apt update
sudo apt install -y "${deps[@]}"

#if kitty was installed with apt, get rid of it
sudo apt remove -y kitty
git clone https://github.com/kovidgoyal/kitty.git 
cd kitty
./dev.sh build

#not cleaning up for now in case user used these packages previously
#a good implementation would track which packages were installed, and 
#only remove those ones
#sudo apt remove "$deps" -y


cd "$curr"
