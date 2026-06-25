#!/bin/bash

function chromium-profile {
	name="$1"
	p="${HOME}/.config/chromium/$1"
	echo "$p"
}

function new-chromium-profile {
	name="$1"
	p="$(chromium-profile "$1")"
	mkdir -p "$p"
	echo "$p"
	# chromium --user-data-dir="$p" --first-run
}

function launch-chromium-profile {
	ddir=$(chromium-profile "$1")	
	if [ ! -d "$ddir" ]; then
		new-chromium-profile "$1"
	fi
	shift #throw away first arg
	chromium --user-data-dir="$ddir" "$@" &
	echo "$@"
}

function launch-chromium-default {
	launch-chromium-profile "Defualt" "$@"
}

