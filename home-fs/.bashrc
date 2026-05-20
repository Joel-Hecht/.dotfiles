# ~/.bashrc: executed by bash(1) for non-login shells.

# For profiling bashrc
# If profiling, need to also remove "exec {BASH_XTACEFD}>/dev/null"
# We use it so autocd does not output, but we need it to spit out timestamps
# Make sure to also comment out end profiling at bottom of bashrc
#PS4='+ $EPOCHREALTIME\011 '
#exec 3>&2 2>/tmp/bashstart.$$.log
#set -x

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't lines starting with space in the history.
# put duplicate lines for preexec
# See bash(1) for more options
HISTCONTROL=ignorespace

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize 

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --hyperlink=auto' 
fi

# kitty colors yayyy!Q!!!
export TERM=xterm-256color

# kitty grep
if [[ ! -z $(which kitty) ]]; then
	alias grep='kitty +kitten hyperlinked_grep --smart-case -L'
	alias ugrep='/usr/bin/grep --color=auto' # [u]sr/bin grep instead of kitty grep
fi

# import all aliases
function _src {
	source $1 || { touch $1 && source $1 ;}
}
_src ${HOME}/.aliases.sh
_src ${HOME}/.funcs.sh
_src ${HOME}/.aliases_bfs.sh
_src ${HOME}/.pyenv.sh

#files not under version control
_src ${HOME}/.path.sh
_src ${HOME}/.work.sh

# rust environment setup
_src ${HOME}/.cargo/env

# shell prompt (PS1)
_src ${HOME}/.fancy_prompt.sh

# enable programmable completion features
_src /usr/share/bash-completion/bash_completion
_src /etc/bash_completion

# bash-preexec
_src ${HOME}/.preexec-setup.sh

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# add things to path
export PATH="${HOME}/.juliaup/bin:$PATH"
export PATH="${HOME}/.kitty/kitty/kitty/launcher:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="/usr/lib/qt6/bin:$PATH"
export PATH="$HOME/bin/aliases:$PATH"
export PATH="$HOME/bin/valiases:$PATH"
export PATH="/usr/local/MATLAB/R2025a/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/.go/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"

#add permissions so chirp can access radios over usb port0
#sudo usermod -a -G $(stat -c %G /dev/ttyUSB0) $USER

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#start ssh for this terminal and add all keys that end in rsa (omits .pub and known_hosts)
for key in ${HOME}/.ssh/*; do 
	fname=$(basename $key)
	if  [[ ! "$fname" =~ .*\.pub$ && ! "$fname" =~ ^known_hosts.* && ! "$fname" =~ ^config$ && ! "$fname" =~ ^authorized_keys.* ]]; then
		eval $(keychain -q --eval "$key" )
	fi
done

#have a terminal exit script, in case we started processes here that i want to remove
trap "${HOME}/.bash_exit.sh" EXIT

# >>>>> source file for buoy >>>>>
# !! Contents within this block are managed by buoy
source ${HOME}/.local/share/buoy/buoy-interface.sh
# <<<<< source file for buoy <<<<<

# End profiling
#set +x
#exec 2>&3 3>&-
