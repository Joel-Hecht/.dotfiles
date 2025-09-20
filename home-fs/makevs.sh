#!/bin/bash
rm ~/.cache/dmenu_run # get rid of dmenu cache

# see dhome/makealiases.sh for what the hell is going on here
bpath="#!/bin/bash"

thispath=$(realpath $0)
thispath=$(dirname "$thispath")
aliaspath="$thispath/bin/valiases"

$(mkdir -p $aliaspath)
count=0

as=$(tail -n +2 "$HOME/.aliases_v.sh" | sed -e 's/alias *//' | sed -e 's/=.*$//')
$(rm -rf $aliaspath/*)

for a in $as; do
	p="$aliaspath/$a""-a"
	VOLUME=~/.VOLUME
	cat > "$p" <<- EOF
	$bpath
	chmod 644 $VOLUME
	echo IN PROGRESS > $VOLUME
	amixer -q -M set Master $count% &>/dev/null
	sed -i "s/= \".*W:/= \"VOLUME: $count% :|: W:/" ~/.i3status.conf
	killall i3bar
	i3bar --bar_id=bar-0 & &>/dev/null 
	echo $count > $VOLUME
	chmod 444 $VOLUME
	EOF
	chmod +x $p
	count=$(( $count + 1 ))
done
