#!/bin/bash
thispath=$(realpath "${BASH_SOURCE[0]}")
thisdir=$(dirname "$thispath")
dhome=$(dirname $(dirname "$thispath"))
bindir="$dhome/bin/"

for f in "$bindir"* ; do
	if [ -f f ]; then
		chmod +x f
	fi
done

chmod +x "$HOME/.bash_exit.sh"
