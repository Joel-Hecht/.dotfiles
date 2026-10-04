# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

parse_git_branch() {
	# Put space in front if we're not vim or venv
	git branch &>/dev/null && [[ -z "$VIM_SERVERNAME" ]] && [[ -z "$VIRTUAL_ENV" ]] && echo -n " "
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' | sed -e 's/$/ /'
}

vim_servername() {
	# Put space in front if we're not venv
	[[ -n "$VIM_SERVERNAME" ]] && [[ -z "$VIRTUAL_ENV" ]] && echo -n " "
	[[ -n "$VIM_SERVERNAME" ]] && echo -n "$VIM_SERVERNAME "
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;37m\]$(vim_servername)$(parse_git_branch)\[\033[00m\]\[\033[01;32m\]\w\[\033[00m\] '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
