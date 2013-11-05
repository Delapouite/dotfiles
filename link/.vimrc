filetype off

set list
set listchars=eol:¶,tab:>-,trail:~,extends:>,precedes:<
set mouse=a
set nocompatible
set number

" tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4

syntax on

" vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" bundles
Bundle 'airblade/vim-gitgutter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/syntastic'