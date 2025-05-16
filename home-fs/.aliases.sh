#!/bin/bash

#navigation
alias dot="cd ~/.dotfiles"
alias dhome="cd ~/.dotfiles/home-fs"
alias dbin="cd ~/.dotfiles/home-fs/bin"

#files
alias config="vim ~/.dotfiles/home-fs/.config/i3/config"
alias aliases="vim ~/.dotfiles/home-fs/.aliases.sh"
alias barconfig="vim ~/.dotfiles/home-fs/.i3status.conf"
alias sl="pope"

#computer control
alias eep="systemctl suspend"

#CTRL+Z -> z to disconnect an app from terminal and remove the terminal
alias z="bg; jobs; disown %1; kill -9 $(xdotool getactivewindow getwindowpid)"

#git / general shortcuts
alias gaa="git add --all"
alias gcm="git commit -m"
alias staged="git diff --name-only --staged"
alias names="git diff --name-only"
alias gp="git pull"
alias push="git push"
alias dp="current=$PWD && dot && gp && cd ""${current}"

#reload bashrc after updates	
alias sb="source ~/.bashrc"

alias pids="ps aux"
alias killpid="kill -9"
alias kf="keyboard_firmware"

#copy last command entered
alias cplast="fc -ln -1 | xargs | xclip -sel c"
alias cpy="xclip -sel c"

#source aliases that act as applications
source ${HOME}/.aliases_dmenu.sh
