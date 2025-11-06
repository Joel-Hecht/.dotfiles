#!/bin/bash

#for bar tray, set which monitor is primary using screen script
sh ~/bin/primarydisplay

#this is what dmenu reads
PATH="$HOME/bin/aliases:$PATH"
PATH="$HOME/bin/valiases:$PATH"
PATH="$HOME/bin/dmenu_specific:$PATH"

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
