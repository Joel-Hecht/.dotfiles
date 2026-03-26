#!/bin/bash

function repo {
	url=$( git remote get-url origin 2> /dev/null )
	if [[ -z "$url" ]]; then
		dc firefox github.com/Joel-Hecht/.dotfiles
	elif [[ "$url" == https* ]]; then
		dc firefox "$url"
	else
		ssh_url=${url#*@} # Delete leading *@
		ssh_home=${ssh_url%:*} # Delete trailing :*
		ssh_name=${ssh_url#*:} # Delete leading *:
		ssh_name=${ssh_name%.*} # Delete trailing .*
		dc firefox "$ssh_home/$ssh_name"
	fi
}

function p {
	if [[ $# -lt 1 ]]; then
		cd ..
	else
		target=""
		for ((i=1; i<=$1; i++)); do
			target+="../"
		done
		cd "$target"
	fi
}
alias b="p"

function lockin {
	conf=$( cat $HOME/.i3status.conf | /usr/bin/grep -v 'order += "tztime local"' )
	echo "$conf" > $HOME/.i3status.conf
	echo "# $( date +%s )" >> $HOME/.i3status.conf
	i3rs &>/dev/null
}

function lockout {
	since=$( cat $HOME/.i3status.conf | /usr/bin/grep -oP '\d{4,}$' ) # it has been much more than 9999 seconds since epoch
	conf=$( cat $HOME/.i3status.conf | /usr/bin/grep -vP '# \d{4,}' )
	echo "$conf" > $HOME/.i3status.conf
	echo "order += \"tztime local\"" >> $HOME/.i3status.conf 
	i3rs &>/dev/null

	rn=$( date +%s )
	diff=$(( $rn - $since ))
	hrs=$(( $diff / 3600 ))
	min=$(( $(( $diff % 3600 )) / 60 ))
	sec=$(( $diff % 60 ))
	echo "locked in for $hrs h $min m $sec s"
}

function findproc {
	if [[ $# -eq 0 ]]; then
		echo "findproc [procname]" >&2
		return 1
	fi

	ps aux | ugrep $1 | ugrep -v grep | ugrep -v findproc
}
alias fp="findproc"

# from https://unix.stackexchange.com/a/561579
function awkn {
	awk -v n=$1 '{ for (i=n; i<=NF; i++) printf "%s%s", $i, (i<NF ? OFS : ORS)}' "$2"
}


function bdh {
	[[ $# -lt 1 ]] && echo "bdh: no location provided" && return

	[[ $# -lt 2 ]] && num=1 || num="$2"

	if ! [[ "$num" =~ ^[0-9]+$ ]]; then
		echo "dh [X] to move the last X downloaded files, X must be a number" >&2
		return 1
	fi
	
	while [[ $num -gt 0 ]]; do
		if [[ $num -eq 1 ]]; then
			fname="$(buoy -e ls -t "$1" | head -1 | tail -1 )"
		else
			#fname="$(buoy -e ls -tl "$1" | /usr/bin/grep ^- | awkn 9 | head -1 | tail -1 | sed -e 's/.*[0-9][0-9]:[0-9][0-9] //')"
			fname="$(buoy -e ls -tl "$1" | awkn 9 | head -1 | tail -1 | sed -e 's/.*[0-9][0-9]:[0-9][0-9] //')"
		fi
		# fullpath="${1}/""\"${fname}"
		fullpath="$(buoy -e echo "${1}/$fname")"
		if [[ $( tail -c 6 <<< "${fullpath}" ) == '.part' ]]; then
			echo "Still downloading!"
			return 1
		else
			echo "$fullpath"
			mv "$fullpath" ./"$fname"
		fi
		num=$(( $num - 1 ))
	done
}
		
alias downhere="bdh \"@/Downloads/\""
alias dh="downhere"

function vm {
	mv "$1" ~/vm/fusion_share/in/
}

function getvm {
	bdh ~/vm/fusion_share/out/ 
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
	ls --color=yes
}

# WIP
function lscd {
	ls --color=yes
	printf "${LSCOLOUR}$( pwd | sed "s|$HOME|~|" )/... ${NC} "
	read -n 1
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
		echo "$( dirname "${@: -1}" )"/"$1" >&2
		cp "$@" && vi "${@: -1}"/"$1"
	else
		cp "$@" && vi "${@: -1}"
	fi
}

function mvvi {
	if [ $# -lt 2 ]; then
		echo "mvvi source destination"
	elif [ -d "${@: -1}" ]; then
		mv "$@" && vi "${@: -1}"/"$1"
	else
		mv "$@" && vi "${@: -1}"
	fi
}

function ccv {
	if [ $# -lt 2 ]; then
		echo "ccv source destination"
	elif [ -d "${@: -1}" ]; then
		cp "$@" && cd "${@: -1}" && vi "${@: -1}"/"$1"
	else
		cp "$@" && cd "$( dirname "${@: -1}" )" && vi "${@: -1}"
	fi
}

function mcv {
	if [ $# -lt 2 ]; then
		echo "mcv source destination"
	elif [ -d "${@: -1}" ]; then
		mv "$@" && cd "${@: -1}" && vi "${@: -1}"/"$1"
	else
		mv "$@" && cd "$( dirname "${@: -1}" )" && vi "${@: -1}"
	fi
}

function mmcv {
	if [ $# -lt 2 ]; then
		echo "mmcv source destination"
	elif [ -d "${@: -1}" ]; then
		echo "\'${@: -1}' already exists, mcving anyway" >&2
		mv "$@" && cd "${@: -1}" && cd "${@: -1}" && vi "${@: -1}"/"$1"
	else
		mkdir "${@: -1}" && mv "$@" && cd "${@: -1}" && vi "${@: -1}"/"$1"
	fi
}

function mccv {
	if [ $# -lt 2 ]; then
		echo "mccv source destination"
	elif [ -d "${@: -1}" ]; then
		echo "\'${@: -1}' already exists, ccving anyway" >&2
		cp "$@" && cd "${@: -1}" && cd "${@: -1}" && vi "${@: -1}"/"$1"
	else
		mkdir "${@: -1}" && cp "$@" && cd "${@: -1}" && vi "${@: -1}"/"$1"
	fi
}

function mkmv {
	if [ ! -n "${@: -1}" ]; then
		echo "mkmv source destination" >&2
	elif [ -d "${@: -1}" ]; then
		echo "\'${@: -1}' already exists, mving anyway" >&2
		mv "$@" 
	else
		mkdir "${@: -1}" && mv "$@" 
	fi
}

function mkcp {
	if [ ! -n "${@: -1}" ]; then
		echo "mkcp source destination" >&2
	elif [ -d "${@: -1}" ]; then
		echo "\'${@: -1}' already exists, cping anyway" >&2
		cp -r "$@"
	else
		mkdir "${@: -1}" && cp -r "$@"
	fi
}

