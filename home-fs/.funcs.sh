#!/bin/bash

source "$HOME"/.funcs_dmenu.sh

function editor {
	${EDITOR} "$@"
}

function copy {
	cat "$1" | cb
}

function unfunc { 
	orig=$( type -a $1 ) 
	unset -f "$1" 
	echo "was $orig"
}

# path stuff i always forget to use
function path { 
	if [ -z "$1" ];then 
		editor ~/.path.sh && source ~/.path.sh
	else
		echo "export PATH=\""$1":\$PATH\"" >> ~/.path.sh && source ~/.path.sh
		echo "export PATH=\""$1":\$PATH\""
	fi	
}
function pathhome {
	echo "export PATH=\"\$HOME/"$1":\$PATH\"" >> ~/.path.sh && source ~/.path.sh
	echo "export PATH=\"\$HOME/"$1":\$PATH\""
}
function pathhere {
	echo "export PATH=\""$( pwd | sed "s!$HOME!\$HOME!g" )":\$PATH\"" >> ~/.path.sh && source ~/.path.sh
	echo "export PATH=\""$( pwd | sed "s!$HOME!\$HOME!g" )":\$PATH\""
}

# make git a little nicer
function pull {
	if [[ -n $( git log --branches --not --remotes ) ]]; then
		echo You are ahead of origin, you might want to git pull --rebase
	else
		git pull
	fi
}
function amend {
	if [[ -n "$( git diff --staged )" ]]; then
		echo You have staged changes, git commit --amend will merge them into the last commit
		echo If you just want to rewrite your commit message, unstage your changes first
	elif [[ -z $( git status | grep "ahead" ) ]]; then
		echo You are up to date with origin, git commit --amend will rewrite history
		echo You probably dont want to do that
	else
		git commit --amend
	fi
}
function clone {
	git clone git@github.com:"$1".git
}

function rust {
	[[ -d $HOME/.test-rust ]] || cp -rL $HOME/.template-rust $HOME/.test-rust
	cd $HOME/.test-rust
	sed -i 's/template/test/' Cargo.toml
	if [[ -n $1 ]]; then
		cargo $@
	else
		vi src/main.rs
		cargo run
	fi
	cd - >/dev/null
}
function dust { rm -rf $HOME/.test-rust; }

function rmscs {
	mkdir /tmp/old 2> /dev/null
	mv /tmp/trash/* /tmp/old 2> /dev/null
	mkdir /tmp/trash 2> /dev/null
	mv ${HOME}/Pictures/SCID* /tmp/trash
}

function scshow {
	kitty +kitten icat "$( _scname )"
}

function schere {
	if [[ -n "$1" ]];then
		# you don't need to add .png when doing schere, but you can if you want
		if [[ "$1" =~ .*\.png$ ]];then
			dest="$1" 
		else
			dest="${1}.png"
		fi
	else
		dest="."
	fi
	echo "$( _scname )"
	mv "$( _scname )" "$dest"
}

function sc {
	file="$( _scname )"
	# open in pinta, or feh if that doesn't work
	( flatpak run com.github.PintaProject.Pinta "$fname" 2> /dev/null ||  feh "$fname" 2> /dev/null ) &
}

function _scname {
	lastID=$(.lastScreenShotID)
	fname="$(ls ${HOME}/Pictures | grep ^SCID"$lastID"_.*.png)"
	echo ${HOME}/Pictures/"$fname"
}

function zipdir {
	if [[ -n ${1} ]]; then
		fname="${1}"
		
		# check if tab-completed dir ends in '/'
		fname=$(echo "$fname" | sed 's#/$##')

		# we should also chop off dirnames before the last filename
		# if your dir name contains the '/' character, tough luck
		dirname="$fname"
		fname=$(echo "$fname" | sed 's#.*/##')

		zip -r "${fname}.zip" "${dirname}"
	else
		echo "usage: zipdir {directory} [options]"
	fi
}

function rmx {
	mkdir /tmp/old 2>/dev/null
	mv /tmp/trash/* /tmp/old 2>/dev/null
	mkdir /tmp/trash 2>/dev/null

	for a; do
		if [[ -f ${a} ]]; then
			mv ${a} /tmp/trash
		elif [[ -d ${a} ]]; then
			read -p "Remove directory ${a}? [Y]/n " yn
			case $yn in
				[Yy]* ) mv ${a} /tmp/trash ;;
				[^Yy]* ) ;;
				* ) mv ${a} /tmp/trash ;;
			esac
		else
			if find -maxdepth 1 -type f -name "*.${a}" >/dev/null; then
				find -maxdepth 1 -type f -name "*.${a}" -exec mv {} /tmp/trash \;
			else
				echo "${a}: didn't remove anything" >&2
			fi
		fi
	done
}

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

	ps aux | grep $1 | grep -v grep | grep -v findproc
}

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
alias vmget="getvm"

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
		mkdir -p "$@" && cd "$1" 2>/dev/null || cd "${@: -1}"
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

function lo {
	libreoffice "$@" &
}

#this needs to be a function so that it has the current context
#running from a file will make a new shell, which doesn't share the 
#environment we are looking to analyze
function edita {
	target="$1"

	decl=$(declare -F "$target")
	if [ -n "$decl" ];then
		#functions have builtin functionality!  Yay!
		cut=$(echo "$decl" | sed "s/^$target //")
		linenumber=$(echo "$cut" | sed "s/ .*$//")
		fname=$(echo "$cut" | sed "s/^[0-9]* //")
	else 
		aliasresult=$(alias "$target")
		pat="^alias\ ${target}='.*"
		if [[ "$aliasresult" =~ $pat ]]; then
			# make line tell source file and line number with this format
			export PS4='(${BASH_SOURCE} :::: ${LINENO}) '

			# need ? on ' because aliases to functions do not get quoted
			line=$(bash -xci : 2>&1 | /usr/bin/grep "alias '\?${target}=" )

			#for some reason I can't trim off these end parens in the same sed.  Whatever
			trim=$(echo "$line" | sed 's/^[0-9]*\:(*//' | sed "s/^(*//") 
			fname=$(echo "$trim" | sed "s/ ::::.*//")
			linenumber=$(echo "$trim" | sed "s/^.* :::: //" | sed "s/).*$//")
		else
			echo "No function or alias in current env named $target"
			return 1
		fi
	fi

	editor "+$linenumber" "$fname"
	sb
}
alias ea="edita"
