# >>> bash-preexec >>>
# define functions and add to precmd_functions to execute before prompt display,
# 					 or to preexec_functions to execute before command execution
shopt -s extdebug
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
function precmd {
	history -a
	return 0
}
function preexec {
	# don't preexec on automatic kitty history functions
	[[ $HISTCMD -le $LASTHISTCMD ]] && return 0
	export LASTHISTCMD=$HISTCMD

	# 1/256 chance to replace commands with pope
	[[ $RANDOM -lt 128 ]] && pope && return 1

	# get command name
	# TODO: treat quoted name w/ spaces as one thing instead of multiple
	arg0=$( awk '{ print $1 }' <<< "$1" )

	# if multiple arguments, assume you were trying to run a command that DNE
	[[ "$arg0" != "$BASH_COMMAND" ]] && return 0

	# if you can just cd there, default to autocd and leave
	[[ -d $arg0 ]] && return 0

	# if only one letter, probably a typo
	[[ ${#arg0} -eq 1 ]] && return 0

	# if command doesn't exist, try bfs
	if [[ -z $( 'type' -t $arg0 ) ]]; then
		# try starting from here first
		source bfs_base -t $arg0 &>/dev/null && return 1

		# next try from root
		source bfs_base -rt $arg0 &>/dev/null && return 1
	fi

	# all else fails, run default command not found behaviour
	return 0
}
