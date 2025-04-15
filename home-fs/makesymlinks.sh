#!/bin/bash

# for recursive calls, get the current dir that we 
# are working on
if [ -z "$1" ]; then
	dir=$(echo $0 | sed 's/[^\/]*$//')
	dir=$(realpath "$dir")
	prefix=$dir
else
	dir=$1
	prefix=$2
fi

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
			
		if [ -e "$projected" ]; then
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

