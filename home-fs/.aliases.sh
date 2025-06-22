#!/bin/bash

#navigation
alias dot="cd ~/.dotfiles"
alias dhome="cd ~/.dotfiles/home-fs"
alias dman="cd ~/.dotfiles/man"
alias dbin="cd ~/.dotfiles/home-fs/bin"
alias down="cd ~/Downloads"
alias dnv="cd ~/.dotfiles/home-fs/.config/nvim"
alias repo="firefox github.com/Joel-Hecht/.dotfiles"
alias me="echo \"$(whoami)@$(hostname)\""

#files
alias config="vim ~/.dotfiles/home-fs/.config/i3/config"
alias aliases="vim ~/.dotfiles/home-fs/.aliases.sh"
alias br="vim ~/.bashrc"
alias barconfig="vim ~/.dotfiles/home-fs/.i3status.conf"
alias sexy="echo sexy!"
alias sex="sexy"

#computer control
alias eep="systemctl suspend"
alias dcq="bg; jobs; disown %1; xdotool getactivewindow windowkill"
alias dc="bg; jobs; disown %1"
alias pids="ps aux"
alias killpid="kill -9"
alias kf="keyboard_firmware"

#git shortcuts
alias gcm="git commit -m"
alias staged="git diff --name-only --staged"
alias gaa="git add --all && git diff --name-only --staged | sed 's/^/staged: /' "
alias names="git diff --name-only"
alias gp="git pull"
alias push="git push"
alias dp="curr=\"\$(pwd)\" && dot && gp ; make ; cd \"\$curr\""
alias grh="git reset --hard origin/main"

#reload after updates	
alias sb="source ~/.bashrc"
alias sa="source ~/.aliases.sh"
alias ms="curr=\"\$(pwd)\" && dhome && ./makesymlinks.sh; cd \"\$curr\""

#pope
alias bs="pope"
alias pg="pope"
alias pd="pope"
alias as="pope"
alias sm="pope"
alias rb="pope"
alias em="pope"
alias sl="pope"
alias bc="pope"
alias fk="pope"

#clipboard
alias cplast="fc -ln -1 | xargs -d'\n' | sed 's/^[[:blank:]]*//;s/[[:blank:]]*$//' | tr -d '\n' |  xclip -sel c"
alias cpy="xclip -sel c"
alias cb="xclip -sel c"

#copy github access token to authenticate on tux
alias accesscpy="curr=\"\$(pwd)\" && cd $HOME/auth && cat access_token_github.txt | cpy ; cd \"\$curr\""
alias ghlogincpy="curr=\"\$(pwd)\" && cd $HOME/auth && cat github_login_cred.txt | cpy ; cd \"\$curr\""

#make ssh kitty-friendly
alias ssh="TERM=xterm-256color ssh"

#source aliases that act as applications
source ${HOME}/.aliases_dmenu.sh

#force load keybinds when starting firefox
alias firefox="i3-msg -q restart && firefox"

#allow bfs to cd
alias bfs="source bfs_base"
alias bfsh="source bfs_base -h"
alias bfsr="source bfs_base -r"
alias bfsf="source bfs_base -f"
alias bfst="source bfs_base -f"
alias dfs="source dfs_base"

#remove .swp files
alias rmswp="rm .*.swp"

#reset calcurse
alias fixcurse="cal/share/calcurse/.calcurse.pid"

#hdmi projecting
alias hdmi="xrandr --output HDMI-1 --mode 1680x1050 --same-as eDP-1 --mode 1680x1050"
alias unhdmi="xrandr --auto"

down_func() {
	fname=$(ls -tl "${HOME}/Downloads" | head -2 | tail -1 | sed -e 's/.*[0-9][0-9]:[0-9][0-9] //')
	fullpath="${HOME}/Downloads/${fname}"
	mv "$fullpath" "./$fname"
}

#move last downloaded file to pwd
alias downhere="down_func"
