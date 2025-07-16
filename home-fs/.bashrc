# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

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
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

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

#import all aliases
source ~/.aliases.sh


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
    *:$HOME/.juliaup/bin:*)
        ;;

    *)
        export PATH=$HOME/.juliaup/bin${PATH:+:${PATH}}
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
alias jpnb="venv && jupyter-notebook"
. "$HOME/.cargo/env"

function mkcd {
	if [ ! -n "$1" ]; then
		echo "Enter a directory name"
	elif [ -d $1 ]; then
		echo "\'$1' already exists"
	else
		command mkdir $1 && cd $1
	fi
}

export TERM=xterm-256color

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#add my custom commands to path
export PATH="$HOME/bin:$PATH"
export PATH="/usr/lib/qt6/bin:$PATH"
export PATH="$HOME/bin/aliases:$PATH"
export PATH="/usr/local/MATLAB/R2025a/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/MuseScore4:$PATH"
