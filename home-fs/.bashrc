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
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export PATH="${HOME}/.kitty/kitty/kitty/launcher/:$PATH" #mine

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' | sed -e 's/$/ /'
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;37m\]$(parse_git_branch)\[\033[00m\]\[\033[01;32m\]\w\[\033[00m\] '

#if [ "$color_prompt" = yes ]; then
#   	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\w\[\033[00m\] '
##   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#   	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\w\[\033[00m\] '
#	#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\[\e[1m\]\w\[\e[0m\]\[\033[01;32m\] '
#    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='kitty +kitten hyperlinked_grep --smart-case -L'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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

#generate random color/image when we start a terminal window
#colorscript random


#MOVED TO I3CONFIG
#needed to source i3bar tray to primary monitor on multi-monitor setup
#should work dynamically with laptop and PC systems
#install xrandr with sudo apt install libx11-dev
#get first available display
#disp=$(xrandr -q | grep " connected" | sed -e 's/ .*$//' | head -1)
#xrandr --output $disp --primary

#append to bash history for this terminal live, instead of when file ends
#useful for copying last command
#When each command is executed, this will append the contents to the active
#bash history list for the current terminal (-a), then pull all history from 
#other terminals (-c), and add the current termianls history tot that file (-r)
#this allows bash (which is a seperate, noninteractable terminal) to read 
#the history live
export PROMPT_COMMAND='history -a'

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

#import all aliases
source ~/.bash_profile
source ~/.aliases.sh
source ~/.funcs.sh
source ~/.aliases_bfs.sh
source ~/.path.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#add my custom commands to path
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
# define functions and add to precmd_functions to have them execute before prompt display,
# 					 or to preexec_functions to have them execute before command execution
shopt -s extdebug
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
function precmd_1 {
	history -a
	return 0
}
function preexec_1 {
	# don't preexec on terminal startup or on things in this script
	# probably should be 
	# if (( __bp_inside_preexec > 0 )); then
	# 	return
	# fi
	[[ $HISTCMD -eq $(( $HISTFILESIZE + 1 )) || $HISTCMD -le $LASTCMD ]] && return 0
	export LASTCMD=$HISTCMD

	# 1/256 chance to replace commands with pope unless you are rui's job
	if [[ $( whoami ) -ne zhao && $RANDOM -lt 128 ]]; then
		pope
		return 1
	fi

	# get command name
	cmd=$( awk '{ print $1 }' <<< "$1" )

	# if you can just cd there, default to shopt autocd and leave
	[[ -d $cmd ]] && return 0 

	# if command doesn't exist, try bfsrt
	if [[ -z $( 'type' -t $cmd ) ]]; then
	   	source bfs_base -rt $cmd 5 &>/dev/null && return 1
	fi

	# all else fails, run default command not found behaviour
	return 0
}
precmd_functions+=(precmd_1)
preexec_functions+=(preexec_1)
