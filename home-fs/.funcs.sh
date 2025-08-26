#!/bin/bash

function downhere {
	[[ $# -eq 0 ]] && num=1 || num="$1"

	if ! [[ "$num" =~ ^[0-9]+$ ]]; then
		echo "dh [X] to move the last X downloaded files, X must be a number" >&2
		return 1
	fi
	
	while [[ $num -gt 0 ]]; do
		fname="$(ls -tl "${HOME}/Downloads" | grep ^- | awk '{ print $NF }' | head -2 | tail -1 | sed -e 's/.*[0-9][0-9]:[0-9][0-9] //')"
		fullpath="${HOME}/Downloads/"${fname}""
		if [[ $( tail -c 6 <<< "$fullpath" ) == '.part' ]]; then
			echo "Still downloading!"
			return 1
		else
			mv "$fullpath" "./$fname"
		fi
		num=$(( $num - 1 ))
	done
}
alias dh="downhere"

function path {
   	echo "export PATH=\""$1":\$PATH\"" >> ~/.bashrc 
}
function pathhome { 
	echo "export PATH=\"\$HOME/"$1":\$PATH\"" >> ~/.bashrc 
}
function pathhere {
	here=$( pwd | sed "s!$HOME!\$HOME!g" )
	echo "export PATH=\""$here":\$PATH\"" >> ~/.bashrc
}

function dc {
	if [[ $# -eq 0 ]]; then
		bg 2> /dev/null
		disown %1
	else
		dc_arg "$@"
	fi
}
function dcq {
	if [[ $# -eq 0 ]]; then
		bg 2> /dev/null
		disown %1
		xdotool getactivewindow windowkill 
	else
		dc_arg -q "$@"
	fi
}

function mkcd {
	if [ ! -n "$1" ]; then
		echo "Enter a directory name" >&2
	elif [ -d "$1" ]; then
		echo "\'$1' already exists" >&2
	else
		mkdir "$1" && cd "$1"
	fi
}

LSCOLOUR='\033[0;32m'
NC='\033[0m'

function cdls {
	cd "$@"
	printf "${LSCOLOUR}$( pwd | sed "s|$HOME|~|" )${NC}\n"
	ls --color=auto
}

function mvcd {
	if [ $# -lt 2 ]; then
		echo "mvcd source destination" >&2
	elif [ -d "${@: -1}" ]; then
		mv "$@" && cd "${@: -1}"
	else
		mv "$@" && cd "$( dirname "${@: -1}" )"
	fi
}

function cpcd {
	if [ $# -lt 2 ]; then
		echo "cpcd source destination"
	elif [ -d "${@: -1}" ]; then
		cp -r "$@" && cd "${@: -1}"
	else
		cp -r "$@" && cd "$( dirname "${@: -1}" )"
	fi
}

function mmc {
	if [ ! -n "${@: -1}" ]; then
		echo "mmc source destination" >&2
	elif [ -d "${@: -1}" ]; then
		echo "\'${@: -1}' already exists, mvcding anyway" >&2
		mv "$@" && cd "${@: -1}"
	else
		mkdir "${@: -1}" && mv "$@" && cd "${@: -1}"
	fi
}

function mcc {
	if [ ! -n "${@: -1}" ]; then
		echo "mcc source destination" >&2
	elif [ -d "${@: -1}" ]; then
		echo "\'${@: -1}' already exists, cpcding anyway" >&2
		cp -r "$@" && cd "${@: -1}"
	else
		mkdir "${@: -1}" && cp -r "$@" && cd "${@: -1}"
	fi
}

function cpvi {
	if [ $# -lt 2 ]; then
		echo "cpvi source destination"
	elif [ -d "${@: -1}" ]; then
		cp "$@" && cd "${@: -1}" && vi "$1"
	else
		cp "$@" && cd "$( dirname "${@: -1}" )" && vi "$1"
	fi
}

function mvvi {
	if [ $# -lt 2 ]; then
		echo "mvvi source destination"
	elif [ -d "${@: -1}" ]; then
		mv "$@" && cd "${@: -1}" && vi "$1"
	else
		mv "$@" && cd "$( dirname "${@: -1}" )" && vi "$1"
	fi
}
