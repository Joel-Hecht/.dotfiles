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
	#dir=$(echo $0 | sed 's/[^\/]*$//')
	dir=$(dirname -- "${BASH_SOURCE[0]}")
	dir=$(cd -- "$MY_PATH" && pwd)
	prefix=$dir
	nextignores=$(cat ignoresymlinks.txt | sed -e 's/^/home-fs\//') #prepend home-fs to all we get for the root dir
	#thisignores=$(echoargs 1 $(cat ignoresymlinks.txt) | sed -e 's/^/home-fs\//')
	thisignores="" #since first call enteres home-fs, all arguments should be prepended with home fs and read as nextignores
else
	dir=$1
	prefix=$2
	nextignores=$(echoargs 0 "${@:3}") #take all args except the first two
	thisignores=$(echoargs 1 "${@:3}")
fi

#echo "thisignores;  $thisignores"
#echo $nextignores

#enable * top check hidden files
shopt -s dotglob

for i in $dir*;  do
	if [ -d "$i" ]; then
		if [[ "$i" != "." ]] && [[ "$i" != ".." ]]; then
			#echo "directory found: $i"
			newdirname=$(echo $i | grep -oP '[^/]*$')
			newargs=$(echo "$nextignores" | grep "^$newdirname""/" | sed -e "s/^$newdirname\///" )
    		echo $newargs | xargs $0 "$i""/" "$prefix" 
			#might want to put dotglob here too
		fi
	elif [ -f "$i" ]; then
		#horrble evil sed
		r=$( echo $i | sed -e "s/${prefix//\//\\/}//" )
		fname=$(echo $r | sed -e 's/.*\///')

		current="$2$r"
		projected="$HOME$r"
		
		ignorematches=$(echo "$thisignores" | grep -w "$fname" )
		if [ -n "$ignorematches" ]; then #if the mtaches are non-empty
			#we do not want to make symlink of this since it is in the ignore file
			echo "ignoring file: $r"
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
			#echo "file exists, removing now"
			$(rm "$projected")
		fi
		
		$(ln -s "$current" "$projected")

	#else
		#echo "no files in $i"
	fi
done

#* will no longer include hidden files after exit
shopt -u dotglob

