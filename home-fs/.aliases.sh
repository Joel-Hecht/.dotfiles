#!/bin/bash

#navigation
alias dot="cd ~/.dotfiles"
alias dhome="cd ~/.dotfiles/home-fs"
alias dman="cd ~/.dotfiles/man"
alias dbin="cd ~/.dotfiles/home-fs/bin"
alias dconf="cd ~/.dotfiles/home-fs/.config"
alias scs="cd ~/Pictures"
alias dnv="cd ~/.dotfiles/home-fs/.config/nvim"
alias proj="cd ~/proj"
alias repo="firefox github.com/Joel-Hecht/.dotfiles"
alias t="firefox www.tumblr.com/"
alias me="echo \"$(whoami)@$(hostname)\""
alias down="cd ~/Downloads"
alias rt="bfs -rt"
alias rs="bfs -rs"
alias s="bfs -s"

#back
alias b="cd .."
alias bb="cd ../.."
alias bbb="cd ../../.."
alias bbbb="cd ../../../.."
alias bbbbb="cd ../../../../.."
alias bbbbbb="cd ../../../../../.."
alias b2="cd ../.."
alias b3="cd ../../.."
alias b4="cd ../../../.."
alias b5="cd ../../../../.."
alias b6="cd ../../../../../.."

# nav for rui
alias drex="cd ~/Downloads/drexel"
alias prog="cd ~/Downloads/program"
alias logs="cd ~/proj/geyserlog/logs"

#files
alias config="vim ~/.dotfiles/home-fs/.config/i3/config"
alias todo="vim ~/.dotfiles/todo"
alias aliases="vim ~/.dotfiles/home-fs/.aliases.sh && source ~/.aliases.sh"
alias funcs="vim ~/.dotfiles/home-fs/.funcs.sh && source ~/.funcs.sh"
alias br="vim ~/.bashrc && source ~/.bashrc"
alias barconfig="vim ~/.dotfiles/home-fs/.i3status.conf"

#computer control
alias eep="systemctl suspend"
alias hibernate="systemctl hibernate"
alias reboot="systemctl reboot"
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
alias kms="sudo pkill -u $(whoami)"

#info
alias ll="ls -l"
alias la="ls -A"
alias llh="ls -lh"
alias lla="ls -lA"
alias llah="ls -lAh"
alias dush="du -sh ?(.)*/"
alias fn="find -name"
alias fin="find -iname"
alias ugrep="/usr/bin/grep -P"
alias cgrep="clear; grep -P"

#git shortcuts
alias gcm="git commit -m"
alias staged="git diff --name-only --staged"
alias gaa="git add --all && git diff --name-only --staged | sed 's/^/staged: /' "
alias names="git diff --name-only"
alias gp="git pull"
alias pull="git pull"
alias push="git push"
alias pp="git pull && git push"
alias dp="curr=\"\$(pwd)\" && dot && gp ; make ; cd \"\$curr\""
alias dm="curr=\"\$(pwd)\" && dot ; make ; cd \"\$curr\""
alias grh="git reset --hard origin/main"
alias changes="git diff --cached"
alias submodules="git submodules update --init --recursive"
alias gitbranch="git checkout -b"

#programs ig
alias chirp="sudo ~/.local/bin/chirp &"
alias icat="kitty +kitten icat"
alias lo="libreoffice"
alias py="python"
alias vpy="[[ -n $( echo $PATH | grep basevenv )]] && venv; python"

#reload after updates	
alias sb="source ~/.bashrc"
alias sa="source ~/.aliases.sh"
alias sf="source ~/.funcs.sh"
alias ms="curr=\"\$(pwd)\" && dhome && ./makesymlinks.sh; cd \"\$curr\""

#clipboard
alias cplast="fc -ln -1 | xargs -d'\n' | sed 's/^[[:blank:]]*//;s/[[:blank:]]*$//' | tr -d '\n' |  xclip -sel c"
alias cpy="xclip -sel c"
alias cb="xclip -sel c"
function copy_func { 
  cat "$1" | cb
}
alias copy=copy_func

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
source ${HOME}/.aliases_v.sh 

# random rui stuff
alias zip="echo zip -r dest.zip dirToZip; zip" # remember how zip works
alias vix="vi -X" # use if vim is slow due to x11 issues
alias fixcurse="rm ${HOME}/.local/share/calcurse/.calcurse.pid"  #reset calcurse
alias stopserver="kill $( ps aux | /usr/bin/grep http.server | head -n 1 | awk '{ print $2 }' )"

# fun
alias sexy="echo sexy!"
alias sex="sexy"
alias bs="pope"
alias md="pope"
alias fs="pope"
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
