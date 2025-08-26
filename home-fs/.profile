#!/bin/bash

#for bar tray, set which monitor is primary using screen script
sh ~/bin/primarydisplay

PATH="$HOME/bin/aliases:$PATH"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
*:$HOME/.juliaup/bin:*)
;;

*)
export PATH=$HOME/.juliaup/bin${PATH:+:${PATH}}
;;
esac

# <<< juliaup initialize <<<
. "$HOME/.cargo/env"

export PATH="$HOME/.elan/bin:$PATH"

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" # ghcup-env
