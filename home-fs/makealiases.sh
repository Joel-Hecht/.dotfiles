#!/bin/bash


bpath="#!/bin/bash"

thispath=$(realpath $0)
thispath=$(dirname "$thispath")
aliaspath="$thispath/bin/aliases"

$(mkdir -p $aliaspath)

as=$(tail -n +2 "$HOME/.aliases.sh" | sed -e 's/alias *//' | sed -e 's/=.*$//')

#note that we are not removing actual bash scripts stored
#in the ~/bin/aliases folder
#if we remove aliases, the symlinks will break, but we may be left
#with lingering stuff
#we could also clear $HOME/bin/aliases if we want to fix it
$(rm -rf $aliaspath/*)

for a in $as; do
	p="$aliaspath/$a""-a"
	cat > "$p" <<- EOF
	$bpath
	shopt -s expand_aliases
	source $HOME/.aliases.sh
	$a 
	EOF
	chmod +x $p
done
