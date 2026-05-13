#!/bin/bash

symtofile() {
	if [[ -L $home_conf/$1 ]]; then
		rm $home_conf/$1
	fi
	if [[ ! -e ~/.config/nitrogen/$1 ]]; then
		cp $move_location/$1 $home_conf/$1
	fi
}

#assuming this script continues to be kept in dhome/scripts
dhome="$(dirname "${BASH_SOURCE[0]}")/.."

pattern_string="{REPLACE_ME_WITH_HOME_REALPATH}"
#home realpath with all / escaped
replace_string=$(echo "$(realpath ~)" | sed -e "s|\/|\\\/|g")

#gitignored+ignoresymlinked - we have to populate this directory using this script
move_location="$dhome/.config/nitrogen"
#we also have to populate this directory using this script
home_conf="$(realpath ~)/.config/nitrogen"
#ignoresymlinked - these files exist in the repo, but should never be deployed
from_location="$dhome/.config/.nitrogen_helper"

#make dotfiles itrogen directory if it doesn't exist
#this is in gitignore
if [[ ! -d "$move_location" ]]; then
	mkdir "$move_location"
fi
#make home nitrogen directory if it doesn't exist
if [[ ! -d "$home_conf" ]]; then
	mkdir "$home_conf"
fi

for i in $from_location/*.cfg; do
	fname=$(echo $i | sed "s/.*\///")
	echo "makenitrogenconfig: added $fname"
	sed "s/$pattern_string/$replace_string/g" "$i" > "$move_location/$fname"
done


# if file is symlink converts to regular
# if file doesn't exist it copies over
# if file exists it does nothing
# so you can locally change nitrogen and not have it overwritten every time you make
symtofile "bg-saved.cfg"
symtofile "nitrogen.cfg"
