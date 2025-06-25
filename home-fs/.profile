#!/bin/bash


#for bar tray, set which monitor is primary using screen script
sh ~/bin/primarydisplay

PATH="$HOME/bin/aliases:$PATH"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
*:$HOME/rui/.juliaup/bin:*)
;;

*)
export PATH=$HOME/rui/.juliaup/bin${PATH:+:${PATH}}
;;
esac

# <<< juliaup initialize <<<
. "$HOME/.cargo/env"

export PATH="$HOME/.elan/bin:$PATH"

# FSL Setup
FSLDIR=/home/rui/fsl
PATH=${FSLDIR}/share/fsl/bin:${PATH}
export FSLDIR PATH
. ${FSLDIR}/etc/fslconf/fsl.sh
