"# mappings

"## fixes

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

" X = dh, x = dl, s = dl, Y = yy, S = cc,

" kakoune: use dl / dh instead, reserve x for the future
noremap X :echo "<NOP>!"<CR>
noremap x :echo "<NOP>!"<CR>

" easymotion
map s <Plug>(easymotion-prefix)

" to the end of the line (like C, D)
noremap Y y$"

noremap S :Files<CR>

nmap <silent> <BS> :nohlsearch<CR>

" no more shift on Lafayette
noremap , :

" indents
nmap <S-Tab> <<
nmap <Tab> >>
vmap <S-Tab> <gv
vmap <Tab> >gv



"## File type specific

" easily navigate in help tags, <C-t> to go back
autocmd FileType help map <buffer> <CR> <C-]>



"## F* keys


map <silent> <F4> :execute "noautocmd Ack --ignore-dir=node_modules --ignore-dir=dist " . expand("<cWORD>")<CR>

map <silent> <F5> :call JsBeautify()<CR>

" emmet
map <silent> <F6> <C-y>,
imap <silent> <F6> <C-y>,

let g:AutoPairsShortcutToggle = '<F7>'

" the V, M and P marks are also available to reach the vimrc sections
map <silent> <F12> :tabedit $MYVIMRC<CR>
map <silent> <S-F12> :tabedit $VIMRUNTIME<CR>


"## leaders

" keep it quite high for commentary - gcc - to work properly)
" set timeoutlen=400
map <Space> <Leader>

map <silent> <Leader><F1> :CtrlP<CR>
map <silent> <Leader><F2> :CtrlPBuffer<CR>

" free remaining letters for leader
" abeimuyz
" ABCEFIMOQSTUVWYZ
"

" search
map <silent> <Leader>f :execute "noautocmd ag " . expand("<cword>")<CR>

" console.log
nmap <Leader>c yiwoconsole.log('<c-r>"', <c-r>")<Esc>^

" kakoune mode
map <silent> <Leader>u :execute "!kak % +" . line('.')<CR><CR>

" paste++
map <Leader>p "0p
map <Leader>P "0P

map <Leader>x :only<CR>
map <Leader>X :cclose<CR>

map <Leader>r :set relativenumber!<CR>
map <Leader>R :set number!<CR>

" space and tabs - T4 by default
map <Leader>s2 :set expandtab ts=2 sts=2 sw=2<CR>
map <Leader>s4 :set expandtab ts=4 sts=4 sw=4<CR>
map <Leader>s8 :set expandtab ts=8 sts=8 sw=4<CR>
map <Leader>t2 :set noexpandtab ts=2 sts=2 sw=2<CR>
map <Leader>t4 :set noexpandtab ts=4 sts=4 sw=4<CR>
map <Leader>t8 :set noexpandtab ts=8 sts=8 sw=8<CR>

" buffers
map <Leader>n :bnext<CR>
map <Leader>N :bprevious<CR>
map <Leader>d :bp\|:bd #<CR>
map <Leader>D :BufOnly<CR>

" windows
" move or open
noremap <silent> <Leader>q :q<CR>
noremap <silent> <Leader><ESC> :q<CR>
noremap <silent> <Leader>w :wincmd w<CR>
noremap <silent> <Leader>h :call WinMove('h')<CR>
noremap <silent> <Leader>k :call WinMove('k')<CR>
noremap <silent> <Leader>l :call WinMove('l')<CR>
noremap <silent> <Leader>j :call WinMove('j')<CR>
" rotate
noremap <Leader>H :wincmd H<CR>
noremap <Leader>K :wincmd K<CR>
noremap <Leader>L :wincmd L<CR>
noremap <Leader>J :wincmd J<CR>
" divide
noremap <Leader>s :wincmd s<CR>
noremap <Leader>v :wincmd v<CR>
" next Quickfix
noremap <Leader>o :cn<CR>

noremap <silent> <Leader>g :NERDTreeFind<CR>
noremap <silent> <Leader>G :NERDTreeToggle<CR>
autocmd FileType nerdtree noremap <buffer> <Leader>g :NERDTreeClose<CR>

" surround
map <Leader>' ysiw'
map <Leader>" ysiw"
map <Leader>( ysiw)
map <Leader>[ ysiw]
map <Leader>{ ysiw}
map <Leader>< ysiw>


"## arrows

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
" noremap h <NOP>
" noremap l <NOP>
