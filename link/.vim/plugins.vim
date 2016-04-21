call plug#begin('~/.vim/bundle')

" themes
Plug 'altercation/vim-colors-solarized'
" use this solarized theme because of black on black bug
Plug 'chriskempson/base16-vim'

Plug 'kana/vim-smartword'

" text objects
" built-ins: wW s p <> t
Plug 'kana/vim-textobj-user'

" built-ins: [] ()b {}B
" j — aj/ij for the closest region between any of () [] or {}
Plug 'Julian/vim-textobj-brace'

" c — ac/ic for a comm
Plug 'glts/vim-textobj-comment'

" i — ai/ii for a block of similarly indented lines / aI/iI for a block of lines with the same indentation
Plug 'kana/vim-textobj-indent'

" built-ins: " ' `
" q — aq/iq for the closest pairs of quotes of any type
Plug 'beloglazov/vim-textobj-quotes'

" _ — a_/i_ for a region between _s such as bar in foo_bar_baz
Plug 'lucapette/vim-textobj-underscore'

" S _ aS/iS for a region filled with various space characters
Plug 'saihoooooooo/vim-textobj-space'

" f — af/if for functions
Plug 'kana/vim-textobj-function'
Plug 'thinca/vim-textobj-function-javascript'

" e — ae/ie for entire buffers
Plug 'kana/vim-textobj-entire'

" v — av/iv for variable segments (camelCase)
Plug 'Julian/vim-textobj-variable-segment'

" , — a,/i, for function params
Plug 'sgur/vim-textobj-parameter'

" http://aftnn.org/post/75730734352/vim-auto-closers-compared
" Plug 'jiangmiao/auto-pairs'
Plug 'cohama/lexima.vim'

" ui
Plug 'scrooloose/nerdtree'
let NERDTreeHijackNetrw = 1
let NERDTreeMinimalUI = 1
" autoclose when only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" netrw++
" Plug 'tpope/vim-vinegar'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '◀'
let g:airline_section_y = '%{strlen(&fenc)?&fenc:"none"},%{&ff} %{getfsize(expand("%%:p"))}b'
let g:airline_section_z = '%3c,%3l/%L %P'
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }

let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = ' '
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

Plug 'tomtom/quickfixsigns_vim'
let g:quickfixsigns_events = ['BufEnter', 'CursorHold', 'CursorMoved', 'InsertLeave', 'InsertChange']

" cvs
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" expand
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsListSnippets = '<s-tab>'
Plug 'honza/vim-snippets'
" Plug 'matthewsimo/angular-vim-snippets'
" Plug 'ervandew/supertab'
Plug 'terryma/vim-multiple-cursors'
"
" cs"' ds" ysiw(
Plug 'tpope/vim-surround'

Plug 'easymotion/vim-easymotion'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_verbose = 0

" gcc
Plug 'tpope/vim-commentary'
" gK / gJ
Plug 'AndrewRadev/splitjoin.vim'
let g:splitjoin_split_mapping = 'gJ'
" <c-y>,
Plug 'mattn/emmet-vim'

" search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'osyo-manga/vim-over'
" Plug 'ctrlpvim/ctrlp.vim'
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/]node_modules|wulp|(\.(git|hg|svn))$'
"   \ }

Plug 'mileszs/ack.vim'
Plug 'tpope/vim-repeat'

" code style
if has('nvim')
	Plug 'benekastah/neomake'
	let g:neomake_javascript_enabled_makers = ['eslint']
	autocmd! BufWritePost * Neomake
else
	Plug 'scrooloose/syntastic'
	let g:syntastic_aggregate_errors = 1
	let g:syntastic_auto_loc_list = 0
	let g:syntastic_check_on_open = 0
	let g:syntastic_javascript_checkers = ['eslint']
	let g:syntastic_error_symbol = "✗"
	let g:syntastic_warning_symbol = "✗"
endif

Plug 'maksimr/vim-jsbeautify'
Plug 'einars/js-beautify'
Plug 'editorconfig/editorconfig-vim'
" show them in red and offers :FixWhitespace
Plug 'bronson/vim-trailing-whitespace'

" markdown live preview
Plug 'shime/vim-livedown', { 'for': 'markdown' }

" filetypes
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" let g:javascript_conceal_null = 'ø'
" let g:javascript_conceal_this = '@'
" let g:javascript_conceal_return = '◀'
" let g:javascript_conceal_undefined = '¿'
" let g:javascript_conceal_NaN = 'ℕ'
" let g:javascript_conceal_prototype = '∷'
" let g:javascript_conceal_static = ''
" let g:javascript_conceal_super = 'ℕ'
" let g:javascript_conceal_arrow_function = '▶'

" markup
Plug 'othree/html5.vim'
Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
" altscript
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
" Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'gkz/vim-ls'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
" Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0
" css
Plug 'wavded/vim-stylus', { 'for': 'stylus' }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }

" Clojure REPL
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'wikitopian/hardmode'

let g:markdown_fenced_languages = ['css', 'html', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml']

call plug#end()

" need to be written here: don't close if add pair just before a word
call lexima#add_rule({'char': '(', 'at': '\%#[0-9a-zA-Z]', 'leave': 0, 'filetype': 'javascript'})
call lexima#add_rule({'char': '[', 'at': '\%#[0-9a-zA-Z]', 'leave': 0, 'filetype': 'javascript'})
call lexima#add_rule({'char': '{', 'at': '\%#[0-9a-zA-Z]', 'leave': 0, 'filetype': 'javascript'})

colorscheme base16-solarized
