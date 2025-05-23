#!/bin/bash

#navigation
alias dot="cd ~/.dotfiles"
alias dhome="cd ~/.dotfiles/home-fs"
alias dbin="cd ~/.dotfiles/home-fs/bin"
alias down="cd ~/Downloads"
alias me="echo \"$(whoami)@$(hostname)\""

#files
alias config="vim ~/.dotfiles/home-fs/.config/i3/config"
alias aliases="vim ~/.dotfiles/home-fs/.aliases.sh"
alias barconfig="vim ~/.dotfiles/home-fs/.i3status.conf"
alias sl="pope"

#computer control
alias eep="systemctl suspend"

#CTRL+Z -> dc to disconnect an app from terminal, dcq also removes the terminal
alias dcq="bg; jobs; disown %1; xdotool getactivewindow windowkill"
alias dc="bg; jobs; disown %1"

#git / general shortcuts
alias gcm="git commit -m"
alias staged="git diff --name-only --staged"
alias gaa="git add --all && git diff --name-only --staged | sed 's/^/staged: /' "
alias names="git diff --name-only"
alias gp="git pull"
alias push="git push"
alias dp="curr=\"\$(pwd)\" && dot && gp ; make ; cd \"\$curr\""

#reload bashrc after updates	
alias sb="source ~/.bashrc"

alias pids="ps aux"
alias killpid="kill -9"
alias kf="keyboard_firmware"

#copy last command entered
alias cplast="fc -ln -1 | xargs -d'\n' | sed 's/^[[:blank:]]*//;s/[[:blank:]]*$//' | tr -d '\n' |  xclip -sel c"
alias cpy="xclip -sel c"

#make ssh kitty-friendly
alias ssh="TERM=xterm-256color ssh"


#source aliases that act as applications
source ${HOME}/.aliases_dmenu.sh
