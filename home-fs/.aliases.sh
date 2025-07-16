#!/bin/bash

#navigation
alias dot="cd ~/.dotfiles"
alias dhome="cd ~/.dotfiles/home-fs"
alias dman="cd ~/.dotfiles/man"
alias dbin="cd ~/.dotfiles/home-fs/bin"
alias scs="cd ~/Pictures"
alias dnv="cd ~/.dotfiles/home-fs/.config/nvim"
alias repo="firefox github.com/Joel-Hecht/.dotfiles"
alias me="echo \"$(whoami)@$(hostname)\""
alias down="cd ~/Downloads"
# nav for rui
alias drex="cd ~/Downloads/drexel"
alias prog="cd ~/Downloads/program"

#files
alias config="vim ~/.dotfiles/home-fs/.config/i3/config"
alias aliases="vim ~/.dotfiles/home-fs/.aliases.sh"
alias br="vim ~/.bashrc"
alias barconfig="vim ~/.dotfiles/home-fs/.i3status.conf"

#computer control
alias eep="systemctl suspend"
alias pids="ps aux"
alias killpid="kill -9"
alias kf="keyboard_firmware"
alias rmswp="rm *.swp *~ 2> /dev/null"
alias rmzip="rm *.zip *.tar *.gz 2> /dev/null"
alias unclean="mv /tmp/trash/* ." # reverse dbin/clean

#git shortcuts
alias gcm="git commit -m"
alias staged="git diff --name-only --staged"
alias gaa="git add --all && git diff --name-only --staged | sed 's/^/staged: /' "
alias names="git diff --name-only"
alias gp="git pull"
alias push="git push"
alias dp="curr=\"\$(pwd)\" && dot && gp ; make ; cd \"\$curr\""
alias grh="git reset --hard origin/main"
alias changes="git diff --cached"

#reload after updates	
alias sb="source ~/.bashrc"
alias sa="source ~/.aliases.sh"
alias ms="curr=\"\$(pwd)\" && dhome && ./makesymlinks.sh; cd \"\$curr\""

#clipboard
alias cplast="fc -ln -1 | xargs -d'\n' | sed 's/^[[:blank:]]*//;s/[[:blank:]]*$//' | tr -d '\n' |  xclip -sel c"
alias cpy="xclip -sel c"
alias cb="xclip -sel c"

#hdmi projecting
alias hdmi="xrandr --output HDMI-1 --mode 1680x1050 --same-as eDP-1 --mode 1680x1050"
alias unhdmi="xrandr --auto"

#copy github access token to authenticate on tux
alias accesscpy="curr=\"\$(pwd)\" && cd $HOME/auth && cat access_token_github.txt | cpy ; cd \"\$curr\""
alias ghlogincpy="curr=\"\$(pwd)\" && cd $HOME/auth && cat github_login_cred.txt | cpy ; cd \"\$curr\""

# make ssh kitty-friendly
alias ssh="TERM=xterm-256color ssh" 
# source aliases that act as applications
source ${HOME}/.aliases_dmenu.sh 

# random rui stuff
alias zip="echo zip -r dest.zip dirToZip; zip" # remember how zip works
alias vix="vi -X" # use if vim is slow due to x11 issues
alias fixcurse="rm ${HOME}/.local/share/calcurse/.calcurse.pid"  #reset calcurse

#allow bfs to cd
alias bfs="source bfs_base"
alias bfsh="source bfs_base -h"
alias bfsr="source bfs_base -r"
alias bfsf="source bfs_base -f"
alias bfst="source bfs_base -t"
alias bfsi="source bfs_base -i"
alias dfs="source dfs_base"

#move last downloaded file to pwd
down_func() {
	fname=$(ls -tl "${HOME}/Downloads" | head -2 | tail -1 | sed -e 's/.*[0-9][0-9]:[0-9][0-9] //')
	fullpath="${HOME}/Downloads/${fname}"
	mv "$fullpath" "./$fname"
}
alias downhere="down_func"
alias dh="downhere"

# add to path
path_func() {
   	echo "export PATH=\""$1":\$PATH\"" >> ~/.bashrc 
}
path_home() { 
	echo "export PATH=\"\$HOME/"$1":\$PATH\"" >> ~/.bashrc 
}
alias path="path_func"
alias pathhome="path_home"

# dc / dcq but fancy
dc_func () {
	if [[ $# -eq 0 ]]; then
		bg 2> /dev/null
		disown %1
	else
		dc_arg "$@"
	fi
}
dcq_func () {
	if [[ $# -eq 0 ]]; then
		bg 2> /dev/null
		disown %1
		xdotool getactivewindow windowkill 
	else
		dc_arg -q "$@"
	fi
}
alias dcq="dcq_func"
alias dc="dc_func"

# fun
alias sexy="echo sexy!"
alias sex="sexy"
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
alias hd="pope"
alias hd="pope"
alias mr="pope"
alias iv="pope"
alias vm="pope"
