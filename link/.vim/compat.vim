" these options are set by default in neovim
" so this file should only be sources in original vim

" gvim - remove menu, toolbar and scrollbars
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
" better than 50
set history=10000
" search++
set hlsearch incsearch
" always display
set laststatus=2
" to resize split windows
set mouse=a

set wildmenu
set autoindent

" jump between start and end HTML tags
runtime! macros/matchit.vim

