:set number relativenumber
:set is
:set hls
:set ic
:set tabstop=4
:set shiftwidth=4
:set softtabstop=0 noexpandtab
set clipboard=unnamedplus | " default vim clipbaord is system clipboard
:syntax enable

autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Save '+' vim register to clipboard when we leave 
autocmd VimLeave * call system("xclip -sel c ", getreg('+'))
