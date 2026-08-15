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
	# kitty appends its prompt hook to PROMPT_COMMAND after bash-preexec
	# installs, so on the first prompt the DEBUG trap fires for kitty's
	# hook and consumes the flag meant for our first command
	if [[ "$BASH_COMMAND ${FUNCNAME[*]}" == *_ksi_* ]]; then
		  __bp_preexec_interactive_mode=on
		  return 0
	fi

	# don't preexec on automatic kitty history functions
	[[ $HISTCMD -le $LASTHISTCMD ]] && return 0
	export LASTHISTCMD=$HISTCMD

	# 1/512 chance to run pope before commands
	[[ $RANDOM -lt 32 ]] && pope && return 0

	# get command name
	# TODO: treat quoted name w/ spaces as one thing instead of multiple
	arg0=$( awk '{ print $1 }' <<< "$1" )

	# if multiple arguments, assume you were trying to run a command that DNE
	[[ "$arg0" != "$BASH_COMMAND" ]] && return 0

	# if only one letter, probably a typo
	[[ ${#arg0} -eq 1 ]] && return 0

	# if command doesn't exist, try nav
	if [[ -z $( 'type' -t $arg0 ) ]]; then
		# if you can just cd there, do that
		[[ -d "$arg0" ]] && cd "$arg0" && return 1

		# try starting from here first
		source bfs_base -t $arg0 &>/dev/null && return 1

		# next try from root unless we're there
		if [[ "$( 'pwd' )" != "$HOME" ]]; then
			source bfs_base -rt $arg0 &>/dev/null && return 1
		fi
	fi

	# all else fails, run default command not found behaviour
	return 0
}
