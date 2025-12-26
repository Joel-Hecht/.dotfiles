#!/bin/bash

# get sublime for apt
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | sudo tee /etc/apt/sources.list.d/sublime-text.sources

#packages installed with apt (run first)
sudo apt update
#sudo apt upgrade -y
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
git gh `_if you got this far you should already have this` \
libx11-dev `x11 support, needed for multi-monitor config` \
calcurse `in-terminal calendar` \
policykit-1-gnome polkitd `polkit needed to authenticate as root from i3wm` \
vim-gtk3 `_install graphical vim, installation gives vim access to system clipboard register`\
python3-venv pip `needed to use pip`\
lua5.4 `_lua language` \
ninja-build gettext cmake unzip curl `tools we need for later to install neovim` \
notepadqq \
ascii \
sl \
python-is-python3 \
sublime-text \
fonts-noto `_display foreign language characters`\
keychain `_ssh-agent / key manager used in bashrc` \
clangd `_for cpp in nvim` \
fd-find fzf `_for nvim ` \
clang-format clang-tidy `_cpp in nvim` \
pylint `python linter for no good reason` \
xsnow `merry christmas` \
kitty-terminfo `tells nvim about kitty for terminal mode` \
gcc `put this here again so ALL PRECVIUS can have escaped newlines`

[[ -e /usr/games/sl ]] && sudo mv /usr/games/sl /usr/games/sl-1

#alias fdfind to fd because that is how i will use if
if [[ -n $(command -v fdfind) && -z $(command -v fd) ]]; then 
	mkdir -p ~/.local/bin/
	ln -s $(which fdfind) ~/.local/bin/fd
fi

#flatpaks
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#pinta
flatpak install flathub com.github.PintaProject.Pinta
#discord
flatpak install flathub com.discordapp.Discord

#rust stuff
if ! [ -d ~/.cargo ]; then 
	sudo apt install cargo 
	sudo apt autoremove rustc
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

	#actual rustup isntalls
	rustup defualt 1.7.0
	rustup target add wasm32-unknown-unknown

else
	echo "rust installed already"
fi

#lean stuff
if ! [ -f "${HOME}/.elan/bin/lean" ]; then
	lean --version || wget -q https://raw.githubusercontent.com/leanprover-community/mathlib4/master/scripts/install_debian.sh && bash install_debian.sh ; rm -f install_debian.sh && source ~/.profile
else
	echo "lean installed already"
fi

dotdir=$(dirname $(realpath "$0"))
bash "$dotdir"/build_kitty_source.sh

#neovim version 0.8 isnt in apt
#we need to build from source
#Solution from https://www.reddit.com/r/debian/comments/188d3wc/neovim_on_debian/ 
#
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

if [[ -z $(command -v janet) || -z $(command -v jpm) ]]; then
	echo "Installing Janet"
	currentdir = $(pwd)
	mkdir -p "${HOME}/apps"
	cd "${HOME}/apps"
	git clone https://github.com/janet-lang/janet.git
	cd janet
	make
	make test
	#make repl
	sudo make install
	sudo make install-jpm-git
	cd "${HOME}/apps"
	sudo rm -rf janet #clean up
	cd "$currentdir"
else 
	echo "Janet already installed"
fi

#Janet Packages
sudo jpm install sh

#instal vimplug for vim if it does not exist already
if [[ -z $(ls ~/.vim/autoload/plug.vim) ]]; then
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

#install vimplug for nvim if it does not exist already
if [[ -z $(ls ~/.local/share/nvim/site/autoload/plug.vim) ]]; then
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
