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

syntax on

" vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" bundles
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'

map <silent> <C-e> :NERDTreeFocus<CR> 
