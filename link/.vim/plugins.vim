call plug#begin('~/.vim/bundle')

" ## themes: base16 {{{

" use this solarized theme because of black on black bug
Plug 'chriskempson/base16-vim' ", { 'commit': 'f3022fb1fdeff22f99a4b4278c8f44c1131836cd'}

" }}}

" ## moves: smartword, easymotion {{{

" normal behavior
" <a href="http://www.vim.org/">www.vim.org</a>
"  # #   # #   #  #  ##  ##  #  #  ##  ##  # #
" plugin behavior
"  # #     #      #   #   #     #   #   #    #
" see ToggleSmartWord in mappings.vim
Plug 'kana/vim-smartword'

" s key
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_verbose = 0
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

" }}}

"## text-objects {{{

" built-ins: wW s p <> t
Plug 'kana/vim-textobj-user'

" built-ins: [] ()b {}B
" j — aj/ij for the closest region between any of () [] or {}
" ( test ) [ test ] { test }
Plug 'Julian/vim-textobj-brace'

" c — ac/ic for a comm
" Plug 'glts/vim-textobj-comment'
" c — ac/ic for a column
Plug 'idbrii/textobj-word-column.vim'

" i — ai/ii for a block of similarly indented lines / aI/iI for a block of lines with the same indentation
Plug 'kana/vim-textobj-indent'

" built-ins: " ' `
" q — aq/iq for the closest pairs of quotes of any type
" ' test ' ` test ` " test "
Plug 'beloglazov/vim-textobj-quotes'

" _ — a_/i_ for a region between _s such as bar in foo_bar_baz
" test_test_test
Plug 'lucapette/vim-textobj-underscore'

" S — aS/iS for a region filled with various space characters
" test   test test
Plug 'saihoooooooo/vim-textobj-space'

" f — af/if for functions
Plug 'kana/vim-textobj-function'
Plug 'thinca/vim-textobj-function-javascript'

" e — ae/ie for entire buffers
Plug 'kana/vim-textobj-entire'

" v — av/iv for variable segments (camelCase)
" testTestTest
Plug 'Julian/vim-textobj-variable-segment'

" , — a,/i, for function params
" (test, test, test)
Plug 'sgur/vim-textobj-parameter'

" m — am/im for method calls
Plug 'thalesmello/vim-textobj-methodcall'

" }}}

"## ui / windows {{{

Plug 'mhinz/vim-startify'
let g:startify_custom_header = ['                                     neovim']

" Plug 'mtth/scratch.vim'
" <Leader>
Plug 'hecal3/vim-leader-guide'

" zen mode
" :Goyo
Plug 'junegunn/goyo.vim'

" :Ranger*
Plug 'rafaqz/ranger.vim'

Plug 'scrooloose/nerdtree'
let NERDTreeHijackNetrw = 1
let NERDTreeMinimalUI = 1
let NERDTreeQuitOnOpen = 1
" autoclose when only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

" Plug 'tomtom/quickfixsigns_vim'
" let g:quickfixsigns_events = ['BufEnter', 'CursorHold', 'CursorMoved', 'InsertLeave', 'InsertChange']
"
" Showmarks++
Plug 'kshenoy/vim-signature'

" :BufOnly
Plug 'vim-scripts/BufOnly.vim'

" }}}

" ## cvs {{{

Plug 'tpope/vim-fugitive'
" :Magit
Plug 'jreybert/vimagit'

" }}}

" ## expand: snippets, deoplete {{{

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsListSnippets = '<s-tab>'

Plug 'honza/vim-snippets'
" Plug 'matthewsimo/angular-vim-snippets'
" Plug 'ervandew/supertab'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'terryma/vim-expand-region'
" vmap v <Plug>(expand_region_expand)
" vmap <C-v> <Plug>(expand_region_shrink)

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" }}}
"
" ## editing {{{

Plug 'tpope/vim-repeat'

" cs"' ds" ysiw(
Plug 'tpope/vim-surround'

" cxiw on 1st word, then again on 2nd word
" cxc to clear pending exchange
Plug 'tommcdo/vim-exchange'

" gl / gL to align by son char
" example with glip=

" $i = 5;
" $username = 'tommcdo';
" $stuff = array(1, 2, 3);

" $i        = 5;
" $username = 'tommcdo';
" $stuff    = array(1, 2, 3);
Plug 'tommcdo/vim-lion'

" gs: cycle true → false, 0 → 1…
Plug 'AndrewRadev/switch.vim'

" http://aftnn.org/post/75730734352/vim-auto-closers-compared
" see bottom of file for config
Plug 'cohama/lexima.vim'

" gcc
Plug 'tpope/vim-commentary'

" gK / gJ: transform JS Object or Array from 1 line to multiline, if in early
" return…
Plug 'AndrewRadev/splitjoin.vim'
let g:splitjoin_split_mapping = 'gJ'

" <c-y>,
Plug 'mattn/emmet-vim'

" }}}

" ## search: fzf {{{

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'osyo-manga/vim-over'


" Plug 'mileszs/ack.vim'
" let g:ackprg = 'ag --vimgrep'
" cnoreabbrev ag Ack
" cnoreabbrev aG Ack
" cnoreabbrev Ag Ack
" cnoreabbrev AG Ack

" }}}

" ## code style: neomake, syntastic, beautify, editorconfig {{{

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

" }}}

" ## filetypes {{{

" if has('nvim')
	Plug 'neovim/node-host'
" endif
" Plug 'pangloss/vim-javascript'
Plug 'mvolkmann/vim-js-arrow-function'

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
Plug 'digitaltoad/vim-pug', { 'for': 'jade' }
" altscript
Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
" Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'gkz/vim-ls', { 'for': 'livescript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
" Plug 'mxw/vim-jsx'
" let g:jsx_ext_required = 0
" css
Plug 'wavded/vim-stylus', { 'for': 'stylus' }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }

" Clojure REPL
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Plug 'wikitopian/hardmode'
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
" Plug '0x0dea/vim-molasses'
" let g:molasses_keys = 'hjkl'
" let g:molasses_wait = 3000

Plug 'lambdatoast/elm.vim', { 'for': 'elm' }

let g:markdown_fenced_languages = ['css', 'html', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml']

" markdown live preview
Plug 'shime/vim-livedown', { 'for': 'markdown' }

" }}}

call plug#end()

" ## extra config {{{

" need to be written here: don't close if add pair just before a word
call lexima#add_rule({'char': '(', 'at': '\%#[0-9a-zA-Z]', 'leave': 0, 'filetype': 'javascript'})
call lexima#add_rule({'char': '[', 'at': '\%#[0-9a-zA-Z]', 'leave': 0, 'filetype': 'javascript'})
call lexima#add_rule({'char': '{', 'at': '\%#[0-9a-zA-Z]', 'leave': 0, 'filetype': 'javascript'})
call lexima#add_rule({'char': '"', 'at': '\%#[0-9a-zA-Z]', 'leave': 0, 'filetype': 'javascript'})
call lexima#add_rule({'char': "'", 'at': '\%#[0-9a-zA-Z]', 'leave': 0, 'filetype': 'javascript'})

if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256
	source ~/.vimrc_background
endif

" }}}

" vim: set foldmethod=marker:
