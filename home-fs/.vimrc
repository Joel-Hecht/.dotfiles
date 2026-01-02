set nocompatible | "use vim instead of vi, even when launching as vi

if has("nvim")
	" we are nvim, do nothing here
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
Plug 'vim-scripts/a.vim'
call plug#end()
" end vimplug stuff

" langauge dependant indents
filetype plugin indent on 

"defualt vimrc textwidth
autocmd FileType text setlocal textwidth=78 

"explit mouse enable
set mouse=a

"  automatically restore to last edited location
"  Replaced by vim-lastplace in vimrc
" autocmd BufReadPost *
"   \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
"   \ |   exe "normal! g`\""
"   \ | endif
" 
" Save '+' vim register to clipboard when we leave 
autocmd VimLeave * call system("xclip -sel c ", getreg('+'))

" Ctrl+Y to copy last yanked text to clipboard ('+' register)
nnoremap <C-y> :let @+=@"<CR>
nnoremap ^ 0
nnoremap 0 ^

" use space as leader key for custom commands
let g:mapleader="\Space>"
nnoremap <SPACE> <Nop>

" copy to clipboard again
nnoremap <Leader>y :let @+=@"<CR> 
" go between buffers and save
nnoremap <Leader>n :w<CR>:bn<CR>
nnoremap <Leader>p :w<CR>:bp<CR>
nnoremap <Leader>a :w<CR>:A<CR>
" edit and source vimrc
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>r :source $MYVIMRC<CR>:noh<CR>
" shortcut for find-replace
nnoremap <Leader>s :%s//g<Left<Left<BS>/
vnoremap <Leader>s :s//g<Left<Left<BS>/
