set nocompatible | "use vim instead of vi, even when launching as vi

if has("nvim")
	" we are nvim, do nothing here
else
	set undodir=~/.vim/undo/
	" set dir=~/.vim/swap//
	" set backupdir=~/.vim/backup//
end
set undofile


:set number relativenumber
:set is | "incremental searching
:set hls
:set ic
:set tabstop=4
:set shiftwidth=4
:set softtabstop=0 noexpandtab
":set clipboard=unnamedplus | " default vim clipbaord is system clipboard
:set ruler | "always show cursor
:set showcmd | "show incomplete commands (should be on by default) 
:syntax enable

" langauge dependant indents
filetype plugin indent on 

"defualt vimrc textwidth
autocmd FileType text setlocal textwidth=78 

"explit mouse enable
set mouse=a

autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Save '+' vim register to clipboard when we leave 
autocmd VimLeave * call system("xclip -sel c ", getreg('+'))

" Ctrl+Y to copy last yanked text to clipboard ('+' register)
nnoremap <C-y> :let @+=@"<CR>

set undodir=~/.vimundo
set undofile
set undolevels=1000
set undoreload=10000
set viminfo+=<500

nnoremap ^ 0
nnoremap 0 ^
