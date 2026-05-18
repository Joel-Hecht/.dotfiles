#!/bin/bash

#for bar tray, set which monitor is primary using screen script
sh ~/bin/primarydisplay

# environments like wsl launch without desktop in a login shell
# we need a quick way to get bashrc when launching these shells, but 
# sourcing directly is an easy way to make your login take 1000 years
alias sb="source ~/.bashrc"

#this is what dmenu reads
export PATH="$HOME/bin/aliases:$PATH"
export PATH="$HOME/bin/valiases:$PATH"
export PATH="$HOME/bin/dmenu_specific:$PATH"
export PATH="${HOME}/.kitty/kitty/kitty/launcher/:$PATH"

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
. "$HOME/.cargo/env"

export PATH="$HOME/.elan/bin:$PATH"

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" # ghcup-env
