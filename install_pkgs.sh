#!/bin/bash

pkgs=(
	fonts-jetbrains-mono fonts-font-awesome fonts-powerline # fonts
	git gh
	wget curl sed grep
	vim vim-gtk3
	gcc make cmake
	fdisk # volume viewer thats worse than lsblk
	calcurse # calendar TUI
	python3-venv python3-pip # needed to use pip
	python-is-python3 ipython3 pipx pylint # useful python stuff
	lua5.4 # lua language
	ninja-build gettext unzip # will use for nvim install
	ascii
	bat tree # useful display stuff
	sl cowsay # very important
	keychain # ssh-agent / key manager used in bashrc
	ripgrep fd-find fzf # useful tools
	clangd clang-format clang-tidy # for cpp in nvim
	build-essential gdb debhelper
	bfs # breadth-first find that we built our bfs on top of
)

#packages installed with apt (run first)
sudo apt update
#sudo apt upgrade -y
sudo apt install ${pkgs[@]}

# pipx installs
pipx install thefuck
pipx inject thefuck setuptools #distutils compatibility to allow thefuck to work out of the box
pipx inject thefuck zombie-imp #we need to add these hack layers to allow deprecated python 3.11 features
pipx install neovim-remote #_opening neovim in a neovim terminal pane can communicate with neovim parent instance
pipx install notebook # jupyter notebook
pipx install mypy # python type checker

[[ -e /usr/games/sl ]] && sudo mv /usr/games/sl /usr/games/sl-1

dotdir=$(dirname $(realpath "${BASH_SOURCE[0]}"))

#####################################################
############# DESKTOP/GRAPHICAL PACKAGES  ###########
####### UNNEEDED IF NOT IN A GRAPHICAL SETTING ######
#####################################################
if [ -n "$XDG_CURRENT_DESKTOP" ]; then
	bash "$dotdir"/desktop_install_packages.sh
fi
#####################################################
#####################################################

#alias fdfind to fd because that is how i will use if
if [[ -n $(command -v fdfind) && -z $(command -v fd) ]]; then
	mkdir -p ~/.local/bin/
	ln -s $(which fdfind) ~/.local/bin/fd
fi

#julia
curl -fsSL https://install.julialang.org | sh

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
	echo "installing lean"
	wget https://raw.githubusercontent.com/leanprover-community/mathlib-tools/master/scripts/install_debian.sh && bash install_debian.sh
	rm -f install_debian.sh && source ~/.profile
	lean --version
else
	lean --version
fi
sudo apt remove code -y

#neovim version 0.8 isnt in apt
#we need to build from source
#Solution from https://www.reddit.com/r/debian/comments/188d3wc/neovim_on_debian/
#here I should check if neovim exists or if the version is less than 0.9.0
nvim_version=$(nvim --version | head -1 | sed "s/[^\.]*\.//" | sed "s/\..*//")
if [[ $nvim_version -lt 9 ||  -z $(command -v nvim)  ]]; then
	sudo apt remove neovim
	currentdir=$('pwd')
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

#install buoy - no routine to update of yet
if [[ -z $(command -v buoy-client) ]]; then
	currentdir=$('pwd')
	mkdir -p "${HOME}/apps"
	cd "${HOME}/apps"
	git clone https://github.com/Joel-Hecht/buoy
	cd buoy
	if [[ -z $(command -v janet) || -z $(command -v jpm) ]]; then
		make janet
		rm -rf janet
	else
		echo "Janet already installed"
	fi
	#build buoy
	make
	cd "${HOME}/apps"
	rm -rf buoy #clean up
	cd "$currentdir"
else
	echo "buoy already installed"
fi

#install vimplug for vim if it does not exist already
if [[ -z $(ls ~/.vim/autoload/plug.vim) ]]; then
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install bash-preexec
if ! [[ -e ~/.bash-preexec.sh ]]; then
	echo "installing bash preexec"
	curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
fi

sudo apt autoremove -y
