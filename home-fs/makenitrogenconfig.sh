#!/bin/bash

symtofile() {
	if [[ -L ~/.config/nitrogen/$1 ]]; then
		rm ~/.config/nitrogen/$1
	fi
	if [[ ! -e ~/.config/nitrogen/$1 ]]; then
		cp ~/.dotfiles/home-fs/.config/nitrogen/$1 ~/.config/nitrogen/$1
	fi
}

#assuming this script continues to be kept in dhome
dhome="$(dirname "${BASH_SOURCE[0]}")"

pattern_string="{REPLACE_ME_WITH_HOME_REALPATH}"
#home realpath with all / escaped
replace_string=$(echo "$(realpath ~)" | sed -e "s|\/|\\\/|g")

#gitignored - we have to populate this directory using this script
move_location="$dhome/.config/nitrogen"
#ignoresymlinked - these files exist in the repo, but should never be deployed
from_location="$dhome/.config/.nitrogen_helper"

#make dotfiles nitrogen directory if it doesn't exist
#this is in gitignore
if [[ ! -d "$move_location" ]]; then
	mkdir "$move_location"
fi

for i in $from_location/*.cfg; do
	fname=$(echo $i | sed "s/.*\///")
	echo "makenitrogenconfig: added $fname"
	sed "s/$pattern_string/$replace_string/g" "$i" > "$move_location/$fname"
done


# if symlink converts to regular, if doesn't exist copies over, if exists does nothing
#symtofile "bg-saved.cfg"
#symtofile "nitrogen.cfg"
