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
alias dnv="cd ~/.dotfiles/home-fs/.config/nvim"
alias b="cd build"
alias bd="cd build.debug"

alias o="cd - >/dev/null" # go to Older directory in this terminal

#buoy navigation
alias m="buoy -m"
alias e="buoy -e"
alias c="buoy -c"

#files
alias config="editor ~/.dotfiles/home-fs/.config/i3/config"
alias todo="editor ~/.dotfiles/todo"
alias aliases="editor ~/.dotfiles/home-fs/.aliases.sh && source ~/.aliases.sh"
alias funcs="editor ~/.dotfiles/home-fs/.funcs.sh && source ~/.funcs.sh"
alias worksh="editor ~/.work.sh && source ~/.work.sh"
alias wrk="worksh"
alias wr="worksh"
alias br="editor ~/.bashrc && source ~/.bashrc"
alias vr="editor ~/.vimrc"
alias nvc="editor ~/.dotfiles/home-fs/.config/nvim/init.lua"
alias barconfig="editor ~/.dotfiles/home-fs/.i3status.conf"

# websites
alias md="dc browser markdownlivepreview.com"
alias t="dc browser www.tumblr.com/"
alias kb="chromium launcher.keychron.com"
alias P="dc browser https://youtu.be/vG0ina57osc?si=nivlqGbcTwJtwWdJ"

#for testing
alias C="[[ -f $HOME/.test.c ]] || cp $HOME/.template.c $HOME/.test.c ; vi $HOME/.test.c && gcc $HOME/.test.c -lm && ./a.out && rm ./a.out"
alias D="rm $HOME/.test.c"
alias cpp="[[ -f $HOME/.test.cpp ]] || cp $HOME/.template.cpp $HOME/.test.cpp ; vi $HOME/.test.cpp && g++ $HOME/.test.cpp && ./a.out && rm ./a.out"
alias Cpp="cpp"
alias dpp="rm $HOME/.test.cpp"
alias Dpp="rm $HOME/.test.cpp"

# build stuff
alias cgb="cargo build"
alias cip="cargo install --path ."
alias cdb="cmake -DCMAKE_BUILD_TYPE=Debug"
alias cbd="cdb" # as funny as it is I find myself typing this all the time instead so whatever
alias crel="cmake -DCMAKE_BUILD_TYPE=Release"

# computer control
alias eep="systemctl suspend"
alias eepy="systemctl suspend"
alias hibernate="systemctl hibernate"
alias reboot="systemctl reboot"
alias kys="systemctl poweroff"
alias kms="sudo pkill -u $(whoami)"
alias background="nitrogen --restore"
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

# process control
alias pids="ps aux"
alias killproc="killall"
alias kp="killproc"
alias fp="findproc"
alias killpid="kill -9"

# info
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

# vim aliases
#alias v="vim"
alias nv="nvim"

# git shortcuts
alias gcm="git commit -m"
alias dif="git diff"
alias staged="git diff --name-only --staged"
alias gaa="git add --all && git diff --name-only --staged | sed 's/^/staged: /' "
alias gau="git add --update && git diff --name-only --staged | sed 's/^/staged: /' "
alias gaup="git add --update --patch"
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
alias changes="git diff --staged"
alias submodules="git submodule update --init --recursive && git submodule update --recursive"
alias unpushed="git log --branches --not --remotes"
alias unadd="git restore --staged"
alias ungaa="git reset --mixed"
alias untrack="git rm --staged"
alias uncommit="git reset --soft HEAD~1"

# copy github access token to authenticate on tux
alias accesscpy="curr=\"\$(pwd)\" && cd $HOME/auth && cat access_token_github.txt | cpy ; cd \"\$curr\""
alias ghlogincpy="curr=\"\$(pwd)\" && cd $HOME/auth && cat github_login_cred.txt | cpy ; cd \"\$curr\""

# programs 
alias chirp="sudo ~/.local/bin/chirp &"
alias icat="kitty +kitten icat"
alias bat="batcat"
alias directiongame="vpy ~/bin/directiongame/final5.py"
alias dg="directiongame"
alias mse="dc wine $HOME/Downloads/mse/mse.exe"
alias ardour="dc Ardour8"
alias judgel="./jpm_tree/bin/judge"
alias dds="docker desktop start"
alias fileshere="dc nautilus ."
alias fh="fileshere"
alias f="fh"
alias dfh="dc nautilus $HOME/Downloads"

# reload after updates	
alias sb="source ~/.bashrc"
alias sa="source ~/.aliases.sh"
alias sf="source ~/.funcs.sh"
alias ms="curr=\"\$(pwd)\" && dhome && scripts/makesymlinks.sh; cd \"\$curr\""
alias reload="sb && sa && sf"

# clipboard
alias cplast="fc -ln -1 | xargs -d'\n' | sed 's/^[[:blank:]]*//;s/[[:blank:]]*$//' | tr -d '\n' |  xclip -sel c"
alias cpy="xclip -sel c"
alias cb="xclip -sel c"

# xrandr
alias hdmi="xrandr --output HDMI-1 --mode 1680x1050 --same-as eDP-1 --mode 1680x1050"
alias unhdmi="xrandr --auto"
alias ruimon="xrandr --output HDMI-1 --right-of eDP-1 --mode 1680x1050"
alias monoff="xrandr --output HDMI-1 --off"
alias ruimain="xrandr --output eDP-1 --left-of HDMI-1 --mode 1920x1080"
alias mainoff="xrandr --output eDP-1 --off"

# misc
alias ssh="TERM=xterm-256color ssh" # make ssh kitty-friendly
alias vix="vi -X" # use if vim is slow due to x11 issues
alias sexy="cowsay sexy!"
alias sex="sexy"
alias whitespace="fd --type file --exec sed -i 's/\s\+$//' {}"
# fixes pdfs and excel spreadsheets becoming transparent
alias helpme="killall compton && sleep 1 && setsid /usr/bin/compton > /dev/null 2>&1 &"

# source aliases that act as applications
source ${HOME}/.aliases_dmenu.sh 

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
