#!/bin/bash

#general
alias me="echo \"$(whoami)@$(hostname)\""
alias dup='dc kitty $( pwd ) 2>/dev/null' # make new terminal in this directory

#navigation
alias dot="cd ~/.dotfiles"
alias dhome="cd ~/.dotfiles/home-fs"
alias dman="cd ~/.dotfiles/man"
alias dbin="cd ~/.dotfiles/home-fs/bin"
alias dconf="cd ~/.dotfiles/home-fs/.config"
alias scs="cd ~/Pictures"
alias proj="cd ~/proj"
alias down="cd ~/Downloads"

alias o="cd - >/dev/null" # go to Older directory in this terminal
alias bb="cd ../.." # bbb, etc. also work, 
alias b2="cd ../.." # b3, b4, etc. also work

#buoy navigation
alias m="buoy -m"
alias e="buoy -e"
alias c="buoy -c"

#files
alias config="${EDITOR} ~/.dotfiles/home-fs/.config/i3/config"
alias todo="${EDITOR} ~/.dotfiles/todo"
alias aliases="${EDITOR} ~/.dotfiles/home-fs/.aliases.sh && source ~/.aliases.sh"
alias funcs="${EDITOR} ~/.dotfiles/home-fs/.funcs.sh && source ~/.funcs.sh"
alias worksh="${EDITOR} ~/.work.sh && source ~/.work.sh"
alias br="${EDITOR} ~/.bashrc && source ~/.bashrc"
alias vr="${EDITOR} ~/.vimrc"
alias barconfig="${EDITOR} ~/.dotfiles/home-fs/.i3status.conf"

# websites
alias md="dc firefox markdownlivepreview.com"
alias t="dc firefox www.tumblr.com/"
alias kb="chromium launcher.keychron.com"
alias P="dc firefox https://youtu.be/vG0ina57osc?si=nivlqGbcTwJtwWdJ"

#for testing
alias C="[[ -f $HOME/.test.c ]] || cp $HOME/.template.c $HOME/.test.c ; vi $HOME/.test.c && gcc $HOME/.test.c -lm && ./a.out && rm ./a.out"
alias D="rm $HOME/.test.c"
alias cpp="[[ -f $HOME/.test.cpp ]] || cp $HOME/.template.cpp $HOME/.test.cpp ; vi $HOME/.test.cpp && g++ $HOME/.test.cpp && ./a.out && rm ./a.out"
alias Cpp="cpp"
alias dpp="rm $HOME/.test.cpp"
alias Dpp="rm $HOME/.test.cpp"
function rust {
	[[ -d $HOME/.test-rust ]] || cp -rL $HOME/.template-rust $HOME/.test-rust
	cd $HOME/.test-rust
	sed -i 's/template/test/' Cargo.toml
	if [[ -n $1 ]]; then
		cargo $@
	else
		vi src/main.rs
		cargo run
	fi
	cd - >/dev/null
}
alias dust="rm -rf $HOME/.test-rust"
alias cgb="cargo build"
alias cdb="cmake -DCMAKE_BUILD_TYPE=Debug"
alias cbd="cdb" # as funny as it is I find myself typing this all the time instead so whatever
alias crel="cmake -DCMAKE_BUILD_TYPE=Release"

#computer control
alias eep="systemctl suspend"
alias eepy="systemctl suspend"
alias hibernate="systemctl hibernate"
alias reboot="systemctl reboot"
alias kys="systemctl poweroff"
alias kms="sudo pkill -u $(whoami)"
alias kf="keyboard_firmware"
alias i3rs="i3-msg restart"
alias i3rl="i3-msg reload"
alias update="sudo apt update"
alias upgrade="sudo apt update && sudo apt upgrade"
alias autopurge="sudo apt autopurge"
alias rshift="xmodmap -e 'keycode 62 = Shift_R NoSymbol' && xmodmap -e 'add shift = Shift_R'"
alias unrshift="xmodmap -e 'keycode 62 = Escape NoSymbol' && xmodmap -e 'remove shift = Escape'"

# remove things
alias unclean="mv /tmp/trash/* ." # reverse dbin/clean
alias rm="rm -d"
alias rmr="rm -rd"
alias rmrf="rm -rfd"

#process control
alias pids="ps aux"
function findproc { ps aux | ugrep "$@" --color=yes | ugrep -v grep --color=yes ; }
alias killproc="killall"
alias kp="killproc"
alias killpid="kill -9"

#info
alias ll="ls -l"
alias la="ls -A"
alias lt="ls -t"
alias llh="ls -lh"
alias lla="ls -lA"
alias llt="ls -lt"
alias lls="ls -lS"
alias llah="ls -lAh"
alias llac="ls -lAt"
alias llth="ls -lth"
alias llsh="ls -lSh"
alias dush="du -sh ?(.)*/"
alias fn="find -name"
alias fin="find -iname"
alias fr="find -regex"
alias fir="find -iregex"
alias cgrep="clear; grep -P"
alias dl="ls ~/Downloads"
alias dll="ll ~/Downloads"
alias difff="kitten diff"

#vim aliases
#alias v="vim"
alias nv="nvim"
alias dnv="cd ~/.dotfiles/home-fs/.config/nvim"
alias nvc="${EDITOR} ~/.dotfiles/home-fs/.config/nvim/init.lua"

#git shortcuts
alias gcm="git commit -m"
alias dif="git diff"
alias staged="git diff --name-only --staged"
alias gaa="git add --all && git diff --name-only --staged | sed 's/^/staged: /' "
alias gau="git add --update && git diff --name-only --staged | sed 's/^/staged: /' "
alias gaup="git add --update --patch"
alias gaap="git add --all --patch"
alias names="git diff --name-only"
alias staged="git diff --name-only --staged"
function pull {
	if [[ -n $( git log --branches --not --remotes ) ]]; then
		echo You are ahead of origin, you might want to git pull --rebase
	else
		git pull
	fi
}
alias gp="git pull"
alias pull="git pull"
alias push="git push"
alias pp="git pull && git push"
alias dp="curr=\"\$(pwd)\" && dot && gp ; make ; cd \"\$curr\""
alias dm="curr=\"\$(pwd)\" && dot ; make ; cd \"\$curr\""
alias grh="git reset --hard origin/main"
alias changes="git diff --staged"
alias submodules="git submodule update --init --recursive && git submodule update --recursive"
alias unpushed="git log --branches --not --remotes"
alias unadd="git restore --staged"
alias ungaa="git reset --mixed"
alias untrack="git rm --staged"
alias uncommit="git reset --soft HEAD~1"
function amend {
	if [[ -n "$( git diff --staged )" ]]; then
		echo You have staged changes, git commit --amend will merge them into the last commit
		echo If you just want to rewrite your commit message, unstage your changes first
	elif [[ -z $( git status | grep "ahead" ) ]]; then
		echo You are up to date with origin, git commit --amend will rewrite history
		echo You probably dont want to do that
	else
		git commit --amend
	fi
}

#copy github access token to authenticate on tux
alias accesscpy="curr=\"\$(pwd)\" && cd $HOME/auth && cat access_token_github.txt | cpy ; cd \"\$curr\""
alias ghlogincpy="curr=\"\$(pwd)\" && cd $HOME/auth && cat github_login_cred.txt | cpy ; cd \"\$curr\""

#programs 
alias chirp="sudo ~/.local/bin/chirp &"
alias icat="kitty +kitten icat"
alias bat="batcat"
alias directiongame="vpy ~/proj/directiongame/final5.py ; venvl"
alias dg="directiongame"
alias mse="dc wine $HOME/Downloads/mse/mse.exe"
alias ardour="dc Ardour8"
alias judgel="./jpm_tree/bin/judge"
alias dds="docker desktop start"
alias fileshere="dc nautilus ."
alias fh="fileshere"
alias f="fh"
alias dfh="dc nautilus $HOME/Downloads"

#reload after updates	
alias sb="source ~/.bashrc"
alias sa="source ~/.aliases.sh"
alias sf="source ~/.funcs.sh"
alias ms="curr=\"\$(pwd)\" && dhome && scripts/makesymlinks.sh; cd \"\$curr\""
alias reload="sb && sa && sf"
function unfunc { orig=$( type -a $1 ) && unset -f "$1" && echo "was $orig" ; }

# path
function path { echo "export PATH=\""$1":\$PATH\"" >> ~/.path.sh && source ~/.path.sh ; }
function pathhome { echo "export PATH=\"\$HOME/"$1":\$PATH\"" >> ~/.path.sh && source ~/.path.sh ; }
function pathhere { echo "export PATH=\""$( pwd | sed "s!$HOME!\$HOME!g" )":\$PATH\"" >> ~/.path.sh && source ~/.path.sh ; }

#clipboard
alias cplast="fc -ln -1 | xargs -d'\n' | sed 's/^[[:blank:]]*//;s/[[:blank:]]*$//' | tr -d '\n' |  xclip -sel c"
alias cpy="xclip -sel c"
alias cb="xclip -sel c"
function copy { cat "$1" | cb ; }

# misc
alias hdmi="xrandr --output HDMI-1 --mode 1680x1050 --same-as eDP-1 --mode 1680x1050"
alias unhdmi="xrandr --auto"
alias ssh="TERM=xterm-256color ssh" # make ssh kitty-friendly
alias vix="vi -X" # use if vim is slow due to x11 issues
alias sexy="cowsay sexy!"
alias sex="sexy"
#fixes pdfs and excel spreadsheets becoming transparent
alias helpme="killall compton && sleep 1 && setsid /usr/bin/compton > /dev/null 2>&1 &"

# source aliases that act as applications
source ${HOME}/.aliases_dmenu.sh 

#more back aliases
alias bbb="cd ../../.."
alias bbbb="cd ../../../.."
alias bbbbb="cd ../../../../.."
alias b3="cd ../../.."
alias b4="cd ../../../.."
alias b5="cd ../../../../.."

# pope
alias sl="[[ $(( $RANDOM % 2 )) -eq 0 ]] && /usr/games/sl-1 || pope"
alias bs="pope"
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
