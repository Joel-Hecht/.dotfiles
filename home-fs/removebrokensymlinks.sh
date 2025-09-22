#!/bin/bash

if [ -z "$1" ]; then
	dir="${HOME}"
else
	dir="$1"
fi 

#enable viewing hidden files
shopt -s dotglob

for i in $dir*; do
	if [ -d "$i" ]; then
		if [[ "$i" != "." ]] && [[ "$i" != ".." ]] && [[ "$i" != ".steam" ]]; then
			#recrusive call for lower directories ignoring .steam
			$0 "$i""/"
		fi
	elif [[ -L "$i" ]]; then
		if [[ -e "$i" ]]; then
			continue	
		else
			echo "removing broken symlink: $i"
			rm "$i"
		fi
	fi
done


