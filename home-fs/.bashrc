# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't lines starting with space in the history.
# put duplicate lines for preexec
# See bash(1) for more options
HISTCONTROL=ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# cd by just typing directory name if it isnt a command
shopt -s autocd
exec {BASH_XTRACEFD}>/dev/null

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize 
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' | sed -e 's/$/ /'
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;37m\]$(parse_git_branch)\[\033[00m\]\[\033[01;32m\]\w\[\033[00m\] '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --hyperlink=auto' 
	if [[ ! -z $(which kitty) ]]; then
    	alias grep='kitty +kitten hyperlinked_grep --smart-case -L'
	fi
	alias ugrep='/usr/bin/grep --color=auto' # [u]sr/bin grep instead of kitty grep
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/pi/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/pi/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

#stay in a base venv always
#we also make an alias for pip here because im a fuck
VENVNAME=".basevenv"
if ! [ -d  "${HOME}/${VENVNAME}" ]; then
	curr=$(pwd)
	cd "${HOME}"
	python3 -m venv "${VENVNAME}"
	cd "$curr"
fi

alias venv="source \"${HOME}/${VENVNAME}/bin/activate\""
alias venvl="deactivate"
alias pip="${HOME}/${VENVNAME}/bin/pip"
. "$HOME/.cargo/env"
export TERM=xterm-256color

# import all aliases
source ~/.aliases.sh || touch ~/.aliases.sh && source ~/.aliases.sh
source ~/.funcs.sh || touch ~/.funcs.sh && source ~/.funcs.sh
source ~/.aliases_bfs.sh || touch ~/.aliases_bfs.sh && source ~/.aliases_bfs.sh
source ~/.path.sh || touch ~/.path.sh && source ~/.path.sh
source ~/.bash_profile || touch ~/.bash_profile && source ~/.bash_profile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# add things to path
export PATH="${HOME}/.kitty/kitty/kitty/launcher/:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="/usr/lib/qt6/bin:$PATH"
export PATH="$HOME/bin/aliases:$PATH"
export PATH="$HOME/bin/valiases:$PATH"
export PATH="/usr/local/MATLAB/R2025a/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# remove evil musescore directory
rm -rf "$HOME/MuseScore4/"

#add permissions so chirp can access radios over usb port0
#sudo usermod -a -G $(stat -c %G /dev/ttyUSB0) $USER

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# extra path things
export PATH="/usr/local/.go/bin:$PATH"
export PATH="nowhere:$PATH"
export PATH="log:$PATH"
export PATH=":$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
condainit () {
	__conda_setup="$("/usr/local/miniconda3/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
		eval "$__conda_setup"
	else
		if [ -f "/usr/local/miniconda3/etc/profile.d/conda.sh" ]; then
			. "/usr/local/miniconda3/etc/profile.d/conda.sh"
		else
			export PATH="/usr/local/miniconda3/bin:$PATH"
		fi
	fi
	unset __conda_setup
}
# <<< conda initialize <<<


[ -f "/home/rui/.ghcup/env" ] && . "/home/rui/.ghcup/env" # ghcup-env

#for manually installed go
export PATH="/usr/local/go/bin:$PATH"

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

# >>> bash-preexec >>>
# define functions and add to precmd_functions to execute before prompt display,
# 					 or to preexec_functions to execute before command execution
shopt -s extdebug
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
function precmd_1 {
	history -a
	return 0
}
function preexec_1 {
	# don't preexec on automatic kitty history functions
	[[ $HISTCMD -le $LASTHISTCMD ]] && return 0
	export LASTHISTCMD=$HISTCMD

	# 1/256 chance to replace commands with pope unless you are rui's job
	[[ $( whoami ) -ne zhao && $RANDOM -lt 128 ]] && pope && return 1

	# get command name
	# TODO: treat quoted name w/ spaces as one thing instead of multiple
	arg0=$( awk '{ print $1 }' <<< "$1" )

	# if multiple arguments, assume you were trying to run a command that DNE
	[[ "$arg0" != "$BASH_COMMAND" ]] && return 0

	# if you can just cd there, default to autocd and leave
	[[ -d $arg0 ]] && return 0 

	# if only one letter, probably a typo
	[[ ${#arg0} -eq 1 ]] && return 0

	# if command doesn't exist, try bfs
	if [[ -z $( 'type' -t $arg0 ) ]]; then
		# try starting from here first
		source bfs_base -t $arg0 &>/dev/null && return 1

		# next try from root
		source bfs_base -rt $arg0 &>/dev/null && return 1
	fi

	# all else fails, run default command not found behaviour
	return 0
}
precmd_functions+=(precmd_1)
preexec_functions+=(preexec_1)
