" viM
set nocompatible

filetype off

set t_Co=256
set clipboard=unnamedplus
set incsearch
set list
set listchars=nbsp:•,eol:¬,tab:\¦\ ,trail:~,extends:>,precedes:<
set mouse=a
set number
set laststatus=2
set hlsearch

" dirs
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set colorcolumn=80,120

" statusline
set statusline=%F\      "filename
set statusline+=[
set statusline+=%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}, "file format (unix, windows)
set statusline+=%{getfsize(expand('%%:p'))}b "file size
set statusline+=]
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

au InsertEnter * hi StatusLine ctermfg=red
au InsertLeave * hi StatusLine ctermfg=white
set timeoutlen=1000 ttimeoutlen=0

let g:airline_theme='solarized'
let g:airline_left_sep='▶'
let g:airline_right_sep='◀'
let g:airline_section_y='%{strlen(&fenc)?&fenc:"none"},%{&ff} %{getfsize(expand("%%:p"))}b'
let g:airline_section_z='%3c,%3l/%L %P'
let g:airline#extensions#tabline#enabled=1

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
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-surround'
Bundle 'maksimr/vim-jsbeautify'
Bundle 'einars/js-beautify'
Bundle 'mattn/emmet-vim'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'mileszs/ack.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
" filetypes
Bundle 'othree/html5.vim'
Bundle 'Delapouite/vim-javascript-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'gkz/vim-ls'
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'

" https://github.com/gmarik/vundle/issues/176#issuecomment-12996269
filetype off
filetype plugin indent on
set background=dark
colorscheme solarized

" shortcuts
let mapleader=","
map <silent> <F1> :NERDTreeFind<CR>
map <silent> <F2> :NERDTreeTabsToggle<CR>
" find current word
map <silent> <F3> :execute "noautocmd Ack --ignore-dir=node_modules --ignore-dir=dist " . expand("<cword>")<CR>
map <silent> <F4> :execute "noautocmd Ack --ignore-dir=node_modules --ignore-dir=dist " . expand("<cWORD>")<CR>
map <silent> <F5> :call JsBeautify()<CR>
" emmet
imap <silent> <F6> <c-y>,
" hardcore
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" gitgutter
highlight clear SignColumn "remove white background

" line on focus
augroup BgHighlight
	autocmd!
	autocmd WinEnter * set cul
	autocmd WinLeave * set nocul
augroup END

" syntax checkers
let g:syntastic_javascript_checkers=['jscs', 'eslint', 'jshint']
let g:syntastic_aggregate_errors=1

" functions
function! WordFrequency() range
	let all = split(join(getline(a:firstline, a:lastline)), '\A\+')
	let frequencies = {}
	for word in all
		let frequencies[word] = get(frequencies, word, 0) + 1
	endfor
	new
	setlocal buftype=nofile bufhidden=hide noswapfile tabstop=20
	for [key,value] in items(frequencies)
		call append('$', key."\t".value)
	endfor
	sort i
endfunction
command! -range=% WordFrequency <line1>,<line2>call WordFrequency()
