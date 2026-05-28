#!/bin/bash
## Setup aliases for python and python-adjacent functions like
## venv, pip, etc
## also make sure a venv always exists

alias ipython="ipython3"
alias py="python"

#stay in a base venv always
#we also make an alias for pip here because im a fuck
VENVNAME=".basevenv"
if ! [ -d  "${HOME}/${VENVNAME}" ]; then
	curr=$(pwd)
	cd "${HOME}"
	python3 -m venv "${VENVNAME}"
	cd "$curr"
fi

# alias venv="source \"${HOME}/${VENVNAME}/bin/activate\""
function venv {
	if [ -z "$VIRTUAL_ENV" ]; then
		source "${HOME}/${VENVNAME}/bin/activate"
	else
		deactivate
	fi
}
#
alias venvl="deactivate"
alias pip="${HOME}/${VENVNAME}/bin/pip"
# use pipx from apt instead
# alias pipx="${HOME}/${VENVNAME}/bin/pipx"

function vpy {
	[[ -n $( echo $PATH | grep .basevenv ) ]] || venv
	if [[ -z $1 ]]; then
		ipython3
	else
		python "$@"
	fi
	deactivate
}
alias jpnb="venv && dc jupyter-notebook && venvl"
