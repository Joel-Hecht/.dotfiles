#!/bin/bash
bpath="#!/bin/bash"

thispath=$(realpath $0)
thispath=$(dirname $(dirname "$thispath")) #this is dhome
aliaspath="$thispath/bin/aliases"

$(mkdir -p $aliaspath)

as=$(tail -n +2 "$HOME/.aliases_dmenu.sh" | sed -e 's/alias *//' | sed -e 's/=.*$//')
fs=$(cat "$HOME/.funcs_dmenu.sh" | grep "function .* {" | sed -e 's/function *//' | sed -e 's/ *{$//')
#note that we are not removing actual bash scripts stored
#in the ~/bin/aliases folder
#if we remove aliases, the symlinks will break, but we may be left
#with lingering stuff
#we could also clear $HOME/bin/aliases if we want to fix it
$(rm -rf $aliaspath/*)

for a in $as $fs; do
	p="$aliaspath/$a""-a"
	cat > "$p" <<- EOF
	$bpath
	shopt -s expand_aliases
	source $HOME/.funcs_dmenu.sh
	source $HOME/.aliases_dmenu.sh
	$a
	EOF
	chmod +x $p
done

#dmenu sources bin from .profile, not .bashrc.  using this, we can control what dmenu sees.  Reducing the number of user scripts that go into dmenu will decrease the number of autocomplete options, which is desirable.  As such, we will only specify specific scripts, instead of source all of ~/bin
#This technically falls under the scope of makesymlinks.txt, but since other dmenu stuff is dealt with in this file, I have added it here instead
#makealiases.sh executes before makesymlinks.sh in normal run order, so we need to make all the files here that will be symlinked in the future.  The issue then is that all the symlinks will not be made, so we need to reference the dotfiles filesystem
#IMPORTANT - for autocomplete to work, you may need to delete ~/.cache/dmenu_cache
base=$(dirname $(dirname $(realpath "$0")))
bins=$(cat ${base}/bins_for_dmenu.txt)
base="${base}/bin/"
mkdir -p "${base}dmenu_specific"
for k in $bins; do
	p=$(ls "$base" | grep -w $k)
	if [ -n "$p" ]; then
		rm "${base}dmenu_specific/$k"
		ln -s "${base}$k" "${base}dmenu_specific/$k"
	fi
done
