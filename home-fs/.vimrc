set nocompatible | "use vim instead of vi, even when launching as vi

if has("nvim") || exists('$NVIM')
	 " THIS DOESN'T WORK BUT IT SHOULD IT ACTUALLY DOESNT EFFECT ANYTHING THOUGH

	 "if we opened vim in a vim/nvim terminal by accident, set these so that it
	 "opens up in the parent nvim instance
	 "This won't affect anything else
	let $GIT_EDITOR = 'nvr -cc vsplit --remote-wait'
	let $VISUAL = 'nvr -cc vsplit --remote'
	let $EDITOR = 'nvr -cc vsplit --remote'

	" we also want to delete git buffers so that remote-wait can exit
	autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
else
	set undodir=~/.vim/undo/
	" set dir=~/.vim/swap//
	" set backupdir=~/.vim/backup//
end

set undofile
set undolevels=1000
set undoreload=10000
set viminfo+=<500

:set number relativenumber
:set is | "incremental searching
:set wildmenu
:set wildmode=longest:full
:set hls
:set ic
:set tabstop=4
:set shiftwidth=4
:set softtabstop=0 noexpandtab
":set clipboard=unnamedplus | " default vim clipbaord is system clipboard
:set ruler | "always show cursor
:set showcmd | "show incomplete commands (should be on by default)
:syntax enable

" vimplug stuff - doesnt work at all right now

call plug#begin()
Plug 'farmergreg/vim-lastplace'
Plug 'kshenoy/vim-signature'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'Joel-Hecht/a.vim'
call plug#end()
" end vimplug stuff

" language dependent indents
filetype plugin indent on

"defualt vimrc textwidth
autocmd FileType text setlocal textwidth=78

"explit mouse enable
set mouse=a

" disable bell sounds from vim (wsl)
set visualbell
set t_vb=

set foldmethod=indent   " fold based on indent
set foldlevelstart=99
autocmd FileType c,cpp,h,hpp setlocal foldmethod=syntax
autocmd BufWinLeave * silent! mkview

"  automatically restore to last edited location
"  should be replaced by vim-lastplace in vimrc but it doesnt work
 autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Save '+' vim register to clipboard when we leave
autocmd VimLeave * call system("xclip -sel c ", getreg('+'))

" Map key chord `jk` to <Esc> in insert mode.
" Useful if we don't have a convenient <Esc> remap
" From https://www.reddit.com/r/vim/comments/ufgrl8/journey_to_the_ultimate_imap_jk_esc/
let g:esc_j_lasttime = 0
let g:esc_k_lasttime = 0
function! JKescape(key)
	if a:key=='j' | let g:esc_j_lasttime = reltimefloat(reltime()) | endif
	if a:key=='k' | let g:esc_k_lasttime = reltimefloat(reltime()) | endif
	let l:timediff = abs(g:esc_j_lasttime - g:esc_k_lasttime)
	return (l:timediff <= 0.05 && l:timediff >=0.001) ? "\b\e" : a:key
endfunction
inoremap <expr> j JKescape('j')
inoremap <expr> k JKescape('k')

command DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p

" Don't copy on x
nnoremap x "_x
nnoremap X "_X

" Ctrl+Y to copy last yanked text to clipboard ('+' register)
nnoremap <C-y> :let @+=@"<CR>
nnoremap ^ 0
nnoremap 0 ^
onoremap ^ 0
onoremap 0 ^

" use space as leader key for custom commands
let g:mapleader="\<Space>"
nnoremap <SPACE> <Nop>

" copy to clipboard again
nnoremap <Leader>y :let @+=@"<CR>
" go between buffers and save
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>p :bp<CR>
nnoremap <Leader>a :A<CR>
" edit vimrc
nnoremap <Leader>v :e $MYVIMRC<CR>
" shortcut for find-replace
nnoremap <Leader>s :%s//g<Left><Left><BS>/
vnoremap <Leader>s :s//g<Left><Left><BS>/
nnoremap <Leader># #:%s//g<Left><Left><BS>/<C-R>//

" underscore-sensitive w/b
nnoremap <Leader>w :set isk-=_<CR>el:set isk+=_<CR>
nnoremap <Leader>b :set isk-=_<CR>bh:set isk+=_<CR>
" can't get it to work in visual/operator mode

" move by 5
nnoremap <Leader>j 5j
nnoremap <Leader>k 5k
vnoremap <Leader>j 5j
vnoremap <Leader>k 5k
onoremap <Leader>j 5j
onoremap <Leader>k 5k
" move by 10
nnoremap <C-j> 10j
nnoremap <C-k> 10k
vnoremap <C-j> 10j
vnoremap <C-k> 10k
onoremap <C-j> 10j
onoremap <C-k> 10k

" toggle fold
nnoremap <Leader>f za
" [L]oad last session's folds
nnoremap <leader>FL :silent! loadview<CR>
" [F]old everything
nnoremap <Leader>FF zM
" [U]nfold everything
nnoremap <Leader>FU zR

if &diff
	" [s]ingle [p]ut
	nnoremap sp :.diffput<CR>0j

	" [w]rite [o]ther only
	nnoremap wo :q!<CR>:wq<CR>
endif

" shortcut for  difforig
" nnoremap <Leader>do :DiffOrig<cr>
" nnoremap <leader>dc :q<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>k
