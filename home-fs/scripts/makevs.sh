#!/bin/bash
rm "$HOME/.cache/dmenu_run" 2>/dev/null # get rid of dmenu cache

# see dhome/makealiases.sh for what the hell is going on here
thispath=$(realpath $0)
thispath=$(dirname $(dirname "$thispath"))
aliaspath="$thispath/bin/valiases"

$(mkdir -p $aliaspath)
$(rm -rf $aliaspath/*)

function _mkv {
	p="$aliaspath/v$1-a"
	#echo "Making valias $p"
	cat > "$p" <<- EOF
	#!/bin/bash
	$HOME/bin/v $2 > /dev/null
	EOF
	chmod +x $p
}

for i in {0..99}; do
	_mkv $( printf '%02d' $i ) $i
done
_mkv "max" 100
