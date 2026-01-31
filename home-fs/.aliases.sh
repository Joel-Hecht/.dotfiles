#!/bin/bash

#navigation
alias dot="cd ~/.dotfiles"
alias dhome="cd ~/.dotfiles/home-fs"
alias dman="cd ~/.dotfiles/man"
alias dbin="cd ~/.dotfiles/home-fs/bin"
alias dconf="cd ~/.dotfiles/home-fs/.config"
alias scs="cd ~/Pictures"
alias proj="cd ~/proj"
alias repo="dc firefox github.com/Joel-Hecht/.dotfiles"
alias clanker="dc firefox chatgpt.com"
alias t="dc firefox www.tumblr.com/"
alias kb="chromium launcher.keychron.com"
alias me="echo \"$(whoami)@$(hostname)\""
alias down="cd ~/Downloads"
alias rt="bfs -rt"
alias rs="bfs -rs"
alias hs="bfs -hs"
alias s="bfs -s"
alias h="bfs -h"

alias o="cd - >/dev/null" # go to Older directory in this terminal
alias P="dc firefox https://youtu.be/vG0ina57osc?si=nivlqGbcTwJtwWdJ"
alias bb="cd ../.." # bbb, etc. also work, 
alias b2="cd ../.." # b3, b4, etc. also work

#buoy navigation
alias m="buoy -m"
alias e="buoy -e"
alias c="buoy -c"

#files
alias config="vim ~/.dotfiles/home-fs/.config/i3/config"
alias todo="vim ~/.dotfiles/todo"
alias aliases="vim ~/.dotfiles/home-fs/.aliases.sh && source ~/.aliases.sh"
alias funcs="vim ~/.dotfiles/home-fs/.funcs.sh && source ~/.funcs.sh"
alias br="vim ~/.bashrc && source ~/.bashrc"
alias vr="vim ~/.vimrc"
alias barconfig="vim ~/.dotfiles/home-fs/.i3status.conf"

#for testing c
alias C="[[ -f $HOME/.test.c ]] || cp $HOME/.template.c $HOME/.test.c ; vi $HOME/.test.c && gcc $HOME/.test.c && ./a.out && rm ./a.out"
alias D="rm $HOME/.test.c"

#computer control
alias eep="systemctl suspend"
alias eepy="systemctl suspend"
alias hibernate="systemctl hibernate"
alias reboot="systemctl reboot"
alias kys="systemctl poweroff"
alias kms="sudo pkill -u $(whoami)"
alias pids="ps aux"
alias killpid="kill -9"
alias kf="keyboard_firmware"
alias kp="killproc"
alias rmswp="rm *.swp *~ 2> /dev/null"
alias rmzip="rm *.zip *.tar *.gz 2> /dev/null"
alias unclean="mv /tmp/trash/* ." # reverse dbin/clean
alias i3rs="i3-msg restart"
alias i3rl="i3-msg reload"
alias rm="rm -d"
alias rmr="rm -rd"
alias dup='dc kitty $( pwd ) 2>/dev/null' # make new terminal in this directory
alias update="sudo apt update"
alias upgrade="sudo apt update && sudo apt upgrade"

#info
alias ll="ls -l"
alias la="ls -A"
alias llh="ls -lh"
alias lla="ls -lA"
alias llah="ls -lAh"
alias dush="du -sh ?(.)*/"
alias fn="find -name"
alias fin="find -iname"
alias fr="find -regex"
alias fir="find -iregex"
alias cgrep="clear; grep -P"
alias dl="ls ~/Downloads"
alias dll="ll ~/Downloads"
alias difff="kitten diff"
alias mypy="~/.basevenv/bin/mypy"
function findproc { ps aux | ugrep "$@" --color=yes | ugrep -v grep --color=yes ; }
function ref { grep '\<'$1'\>' ; }

#vim aliases
#alias v="vim"
alias nv="nvim"
alias dnv="cd ~/.dotfiles/home-fs/.config/nvim"
alias nvc="nvim ~/.dotfiles/home-fs/.config/nvim/init.lua"

#git shortcuts
alias gcm="git commit -m"
alias dif="git diff"
alias staged="git diff --name-only --staged"
alias gaa="git add --all && git diff --name-only --staged | sed 's/^/staged: /' "
alias gaap="git add --all --patch"
alias names="git diff --name-only"
alias staged="git diff --name-only --staged"
alias gp="git pull"
alias pull="git pull"
alias push="git push"
alias pp="git pull && git push"
alias dp="curr=\"\$(pwd)\" && dot && gp ; make ; cd \"\$curr\""
alias dm="curr=\"\$(pwd)\" && dot ; make ; cd \"\$curr\""
alias grh="git reset --hard origin/main"
alias changes="git diff --cached"
alias submodules="git submodule update --init --recursive && git submodule update --recursive"
alias unpushed="git log --branches --not --remotes"
alias unadd="git restore --staged"
alias ungaa="git reset --mixed"
alias untrack="git rm --cached"
alias uncommit="git reset --soft HEAD~1"
function amend {
	if [[ -z "$( git diff --staged )" ]]; then
		git commit --amend
	else
		echo You have staged changes, git commit --amend will merge them into the last commit
		echo If you just want to rewrite your commit message, unstage your changes first
	fi
}
#copy github access token to authenticate on tux
alias accesscpy="curr=\"\$(pwd)\" && cd $HOME/auth && cat access_token_github.txt | cpy ; cd \"\$curr\""
alias ghlogincpy="curr=\"\$(pwd)\" && cd $HOME/auth && cat github_login_cred.txt | cpy ; cd \"\$curr\""

#programs 
alias chirp="sudo ~/.local/bin/chirp &"
alias icat="kitty +kitten icat"
alias lo="libreoffice"
alias bat="batcat"
alias ipython="ipython3"
function py {
	if [[ -z $1 ]]; then
		ipython3
	else
		python $@
	fi
}
function vpy {
	[[ -n $( echo $PATH | ugrep venv ) ]] || venv
	python "$@"
	venvl
}
alias jpnb="venv && dc jupyter-notebook && venvl"
alias directiongame="vpy ~/proj/directiongame/final5.py ; venvl"
alias dg="directiongame"
alias mse="dc wine $HOME/Downloads/mse/mse.exe"
alias ardour="dc Ardour8"

#reload after updates	
alias sb="source ~/.bashrc"
alias sa="source ~/.aliases.sh"
alias sf="source ~/.funcs.sh"
alias ms="curr=\"\$(pwd)\" && dhome && ./makesymlinks.sh; cd \"\$curr\""
alias reload="sb && sa && sf"
function unfunc { orig=$( type -a $1 ) && unset -f "$1" && echo "was $orig" ; }

# path
function path { echo "export PATH=\""$1":\$PATH\"" >> ~/.path.sh ; }
function pathhome { echo "export PATH=\"\$HOME/"$1":\$PATH\"" >> ~/.path.sh  ; }
function pathhere { echo "export PATH=\""$( pwd | sed "s!$HOME!\$HOME!g" )":\$PATH\"" >> ~/.path.sh ; }
function v { dc_arg $HOME/bin/v_base $1 &>/dev/null ; }

#clipboard
alias cplast="fc -ln -1 | xargs -d'\n' | sed 's/^[[:blank:]]*//;s/[[:blank:]]*$//' | tr -d '\n' |  xclip -sel c"
alias cpy="xclip -sel c"
alias cb="xclip -sel c"
function copy { cat "$1" | cb ; }

# misc
alias hdmi="xrandr --output HDMI-1 --mode 1680x1050 --same-as eDP-1 --mode 1680x1050"
alias unhdmi="xrandr --auto"
alias ssh="TERM=xterm-256color ssh" # make ssh kitty-friendly
alias zip="echo zip -r dest.zip dirToZip; zip" # remember how zip works
alias vix="vi -X" # use if vim is slow due to x11 issues
alias sexy="cowsay sexy!"
alias sex="sexy"
#fixes pdfs and excel spreadsheets becoming transparent
alias helpme="killall compton && sleep 1 && setsid /usr/bin/compton > /dev/null 2>&1 &"

# source aliases that act as applications
source ${HOME}/.aliases_dmenu.sh 
source ${HOME}/.aliases_v.sh 

#more back aliases
alias bbb="cd ../../.."
alias bbbb="cd ../../../.."
alias bbbbb="cd ../../../../.."

# pope
alias sl="[[ $(( $RANDOM % 2 )) -eq 0 ]] && /usr/games/sl-1 || pope"
alias bs="pope"
alias md="pope"
alias pg="pope"
alias pd="pope"
alias as="pope"
alias sm="pope"
alias rb="pope"
alias em="pope"
alias fk="pope"
alias mr="pope"
alias iv="pope"
alias ol="pope"
alias al="pope"
alias yp="pope"
alias aw="pope"
alias b1="pope"
alias 1b="pope"
alias 2b="pope"
alias 3b="pope"
alias 4b="pope"
alias 5b="pope"
alias 6b="pope"
alias llha="pope"
alias :w="cowsay hi i am vim"
alias :wq="cowsay hi i am vim && sleep 2 && exit"
alias :q=":wq"
alias :q!=":wq"
