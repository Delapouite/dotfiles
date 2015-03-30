filetype off

set list
set listchars=eol:¬,tab:\¦\ ,trail:~,extends:>,precedes:<
"set mouse=a"
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
Bundle 'tpope/vim-surround'
Bundle 'maksimr/vim-jsbeautify'
Bundle 'einars/js-beautify'
" Bundle 'Valloric/YouCompleteMe'

" shortcuts
let mapleader=","
map <silent> <F2> <plug>NERDTreeTabsToggle<CR>
map <silent> <F3> :execute "noautocmd vimgrep /" . expand("<cword>") . "/j **/*" . expand("%:e") <Bar> cw<CR>
map <silent> <F4> :call JsBeautify()<CR>


" gitgutter
highlight clear SignColumn "remove white background

augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

set clipboard=unnamedplus
