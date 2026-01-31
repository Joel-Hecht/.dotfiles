syntax on

source ~/.vim/after/plugin/highlights.vim

highlight! pythonEscape ctermfg=lightmagenta " \n inside a string, etc.
" highlight! pythonBuiltin ctermfg=yellow cterm=bold
highlight! pythonFunction cterm=bold ctermfg=lightyellow
highlight! pythonInclude ctermfg=lightblue " same as Statement
