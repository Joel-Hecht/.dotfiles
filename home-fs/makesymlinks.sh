#!/bin/bash

echoargs () {
	flag=""
	if [ $1 -eq 1 ]; then
		flag="v"
	fi
	shift
	for arg in "$@"; do
		if echo "$arg" | grep -q"$flag" "/"; then
			echo "$arg"
		fi
	done
}

# for recursive calls, get the current dir that we 
# are working on
if [ -z "$1" ]; then
	dir=$(echo $0 | sed 's/[^\/]*$//')
	dir=$(realpath "$dir")
	prefix=$dir
	nextignores=$(echoargs 0 $(cat ignoresymlinks.txt))
	thisignores=$(echoargs 1 $(cat ignoresymlinks.txt))
else
	dir=$1
	prefix=$2
	nextignores=$(echoargs 0 "$@")
	thisignores=$(echoargs 1 "$@")
fi

echo $thisignores
echo $nextignores

#enable * top check hidden files
shopt -s dotglob

for i in $dir*; do
	if [ -d "$i" ]; then
		if [[ "$i" != "." ]] && [[ "$i" != ".." ]]; then
			echo "directory found: $i"
			$0 "$i/" "$prefix"
			#might want to put dotglob here too
		fi
	elif [ -f "$i" ]; then
		r=$( echo $i | sed -e "s/${prefix//\//\\/}//" )
		
		current="$2$r"
		projected="$HOME$r"
		
		if [ "$current" == $(realpath $0) ]; then
			#we do not want to make symlink of this bash file
			continue
		fi
		
		echo "creating symlink $current -> $projected"
		
		#we have to make the projected dir if it doesnt already exist
			#it is wasteful to do this on every file instead of every
			#directory, but due to the way the program is structured
			#and the fact that i don't care we will not be fixing that
		proj_dir=$(dirname "$projected")
		$(mkdir -p "$proj_dir")

		#we need to check if it is a symlink (broken) or if it is a file at all (in which case we overwrite)
		if [[ -e "$projected" || -L "$projected" ]]; then
			echo "file exists, removing now"
			$(rm "$projected")
		fi
		
		$(ln -s "$current" "$projected")

	else
		echo "no files in $i"
	fi
done

#* will no longer include hidden files after exit
shopt -u dotglob

