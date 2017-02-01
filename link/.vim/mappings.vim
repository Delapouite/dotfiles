"# mappings

"## fixes {{{

" esc hatch
inoremap jj <ESC>
inoremap jk <ESC>:w<CR>

" make K more consistent with J (J = join, K = split)
nnoremap K i<CR><Esc>k$

" bye bye ex mode
noremap Q :echo "<NOP>!"<CR>

" redo
map U <C-r>

" sudo write
command! W w !sudo dd of=%

" inconsistent default bindings
"    d   y   c
" h  X   yh  ch
" l  x   yl  s
" _  dd  Y   S
" $  D   y$  C

" X = dh, x = dl, s = cl, Y = yy, S = cc

" easymotion
nmap s <Plug>(easymotion-s2)

" to the end of the line (like C, D)
noremap Y y$"

nmap <silent> <BS> :nohlsearch<CR>

" no more shift on Lafayette
nnoremap , :
vnoremap , :
" nnoremap <CR> :

" indents
nmap <S-Tab> <<
nmap <Tab> >>
vmap <S-Tab> <gv
vmap <Tab> >gv

if has('nvim')
	tnoremap <Esc>q <C-\><C-n>
endif

" kakoune goto, easier to type despite 2 letters
nnoremap gh 0
nnoremap gH ^
nnoremap gl $

" }}}

"## file type specific {{{

" easily navigate in help tags
autocmd FileType help map <buffer> <CR> <C-]>
autocmd FileType help map <buffer> <BS> <C-T>

" }}}

"## F* keys {{{

" emmet
map <silent> <F1> :vert help<CR>
map <silent> <F2> <C-y>,
imap <silent> <F2> <C-y>,

" the V, M and P marks are also available to reach the vimrc sections
map <silent> <F12> :tabedit $MYVIMRC<CR>
map <silent> <S-F12> :tabedit $VIMRUNTIME<CR>

" }}}

"## leaders {{{

let g:lmap = {}

" keep it quite high for commentary - gcc - to work properly)
" set timeoutlen=400
map <Space> <Leader>

" util to fill desc for vim-guide-key
function! s:Lmap (keys, rhs, desc)
	execute "map <silent> <Leader>".a:keys ":".a:rhs."<CR>"
	let a:k = split(a:keys, '\zs')
	if len(a:keys) == 1
		let g:lmap[a:keys] = [a:rhs, a:desc]
	endif
	if len(a:keys) == 2
		let g:lmap[a:k[0]][a:k[1]] = [a:rhs, a:desc]
	endif
	if len(a:keys) == 3
		let g:lmap[a:k[0]][a:k[1].a:k[2]] = [a:rhs, a:desc]
	endif
endfunction

" free remaining letters for leader
" aceuz
" ABCEFIMOQSTUVWYZ

" b buffers
let g:lmap.b = { 'name': '+buffers' }
call s:Lmap('a', 'b#', 'alt buf')
call s:Lmap('bo', 'BufOnly', 'only')
call s:Lmap('bb', 'exe "Buffers"', 'buffers')
call s:Lmap('d', 'bp\|:bd #', 'delete buf')
call s:Lmap('n', 'bnext', 'next buf')
call s:Lmap('N', 'bprevious', 'prev buf')

" f find - with fzf
let g:lmap.f = { 'name': '+find' }
call s:Lmap('f`', 'exe "Marks"', 'marks')
call s:Lmap('fb', 'exe "Buffers"', 'buffers')
call s:Lmap('fc', 'exe "Commits"', 'commits')
call s:Lmap('fC', 'exe "BCommits"', 'buffer commits')
call s:Lmap('ff', 'exe "GFiles"', 'git files')
call s:Lmap('fF', 'exe "Files"', 'files')
call s:Lmap('fh', 'exe "History"', 'history')
call s:Lmap('fg', 'exe "GFiles?"', 'git status')
call s:Lmap('fl', 'exe "Lines"', 'lines')
call s:Lmap('fm', 'exe "Maps"', 'maps')
map <silent> <Leader>fw :execute "Ag " . expand("<cword>")<CR>
call s:Lmap('fW', 'exe "Windows"', 'windows')
call s:Lmap('f:', 'exe "Commands"', 'Commands')
call s:Lmap('f/', 'exe "History/"', 'History')

" g git - with fugitive
let g:lmap.g = { 'name': '+git' }
call s:Lmap('gd', 'exe "Gdiff"', 'diff')
call s:Lmap('gs', 'exe "Gstatus"', 'status')

" i indents space and tabs - T2 by default
let g:lmap.i = { 'name': '+indent' }
call s:Lmap('is2', 'set expandtab ts=2 sts=2 sw=2', 'space 2')
call s:Lmap('is4', 'set expandtab ts=4 sts=4 sw=4', 'space 4')
call s:Lmap('is8', 'set expandtab ts=8 sts=8 sw=8', 'space 8')
call s:Lmap('it2', 'set noexpandtab ts=2 sts=2 sw=2', 'tab 2')
call s:Lmap('it4', 'set noexpandtab ts=4 sts=4 sw=4', 'tab 4')
call s:Lmap('it8', 'set noexpandtab ts=8 sts=8 sw=8', 'tab 8')

" m major mode (js)
let g:lmap.m = { 'name': '+major mode' }
call s:Lmap('mb', 'call JsBeautify()', 'beautify')
map <Leader>c yiwoconsole.log('<c-r>"', <c-r>")<Esc>^
map <Leader>me <C-y>,
map <Leader>e <C-y>,

" p paste++
let g:lmap.p = { 'name': '+paste' }
map <Leader>pp "0p
map <Leader>pP "0P
map <Leader>pl :call Paste(v:register, "l", "p")<CR>
map <Leader>pL :call Paste(v:register, "l", "P")<CR>
map <Leader>pc :call Paste(v:register, "v", "p")<CR>
map <Leader>pC :call Paste(v:register, "v", "P")<CR>

" r ranger → does not work on neovim
let g:lmap.r = { 'name': 'ranger' }
call s:Lmap('rr', 'Ranger', 'current dir')
call s:Lmap('rw', 'RangerWorkingDirectory', 'working dir')

let g:smartWordEnabled = 0
function! g:ToggleSmartWord()
	if g:smartWordEnabled
		unmap w
		unmap b
		unmap e
		unmap ge
		let g:smartWordEnabled = 0
	else
		map w  <Plug>(smartword-w)
		map b  <Plug>(smartword-b)
		map e  <Plug>(smartword-e)
		map ge <Plug>(smartword-ge)
		let g:smartWordEnabled = 1
	endif
endfunction

" t toggles
let g:lmap.t = { 'name': '+toggle' }
call s:Lmap('tc', 'set cursorline! cursorcolumn!', 'cursor cross')
call s:Lmap('td', 'call deoplete#toggle()', 'deoplete')
" call s:Lmap('tf', 'NERDTreeFind', 'tree find')
call s:Lmap('th', 'call ToggleHardMode()', 'hard mode')
call s:Lmap('tm', 'SignatureToggleSigns', 'marks')
call s:Lmap('tn', 'set number!', 'number')
call s:Lmap('tr', 'set relativenumber!', 'relative number')
call s:Lmap('ts', 'set spell!', 'spell')
" call s:Lmap('tt', 'NERDTreeToggle', 'tree')
call s:Lmap('tw', 'call ToggleSmartWord()', 'smartword')
call s:Lmap('tW', 'set list!', 'whitespace')
call s:Lmap('tz', 'Goyo', 'zen mode')
call s:Lmap('t-', 'set iskeyword+=\-', 'dash in keyword')

" x quickfix
let g:lmap.x = { 'name': '+quickfix' }
call s:Lmap('xc', 'cclose', 'close')
call s:Lmap('xn', 'cnext', 'next')
call s:Lmap('xp', 'cprevious', 'previous')

"### single letter

" kakoune mode
map <silent> <Leader>u :term "kak % +" . line('.')<CR>

" buffers
call s:Lmap('w', 'w', 'write')

" windows
" move or open
call s:Lmap('q', 'q', 'quit win')
map <silent> <Leader><ESC> :q<CR>

call s:Lmap('h', 'call WinMove("h")', 'move ← win')
call s:Lmap('j', 'call WinMove("j")', 'move ↓ win')
call s:Lmap('k', 'call WinMove("k")', 'move ↑ win')
call s:Lmap('l', 'call WinMove("l")', 'move → win')
" rotate
call s:Lmap('H', 'wincmd H', 'rotate ← win')
call s:Lmap('J', 'wincmd J', 'rotate ↓ win')
call s:Lmap('K', 'wincmd K', 'rotate ↑ win')
call s:Lmap('L', 'wincmd L', 'rotate → win')
" divide
call s:Lmap('s', 'wincmd s', 'split win')
call s:Lmap('v', 'wincmd v', 'vsplit win')
call s:Lmap('=', 'wincmd =', 'equal win')
" maximize
noremap <silent> <Leader>+ :wincmd _<CR>:wincmd <bar><CR>
" other numbers are reserved by airline
" call s:Lmap('0', 'NERDTreeToggle', 'NERDTree')
call s:Lmap('0', 'Startify', 'Startify')

" surround
map <Leader>' ysiw'
map <Leader>" ysiw"
map <Leader>( ysiw)
map <Leader>[ ysiw]
map <Leader>{ ysiw}
map <Leader>< ysiw>

" jump to orphans
map <Leader>) g)
map <Leader>] g]
map <Leader>} g}

" }}}

"## arrows {{{

" normal mode
nmap <silent> <Left> <<
nmap <silent> <Right> >>
nnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>
nnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>
nnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>
nnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>

" visual mode
vmap <silent> <Left> <
vmap <silent> <Right> >
vnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>gv
vnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>gv
vnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>gv
vnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>gv

" insert mode
imap <silent> <Left> <C-D>
imap <silent> <Right> <C-T>
inoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>a
inoremap <silent> <Down> <Esc>:call AddEmptyLineAbove()<CR>a
inoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>a
inoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>a

" }}}

" ## misc {{{

" register display spacemacs like guide
call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

" auto refresh on save
augroup mappings
	autocmd! BufWritePost mappings.vim source %
augroup END

" }}}

" vim: set foldmethod=marker:
