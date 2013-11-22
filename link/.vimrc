filetype off

set list
set listchars=eol:¬,tab:\¦\ ,trail:~,extends:>,precedes:<
set mouse=a
set nocompatible
set number
set laststatus=2

" tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent

syntax on

" vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" bundles
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'scrooloose/syntastic'
Bundle 'digitaltoad/vim-jade'
Bundle 'kien/ctrlp.vim'

" shortcuts
let mapleader=","
map <silent> <F2> <plug>NERDTreeTabsToggle<CR>
map <silent> <F3> :execute "noautocmd vimgrep /" . expand("<cword>") . "/j **/*" . expand("%:e") <Bar> cw<CR>

" git gutter
highlight clear SignColumn "remove white bg
