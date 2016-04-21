" fixes

" make K more consistent with J (J = join, K = split)
nnoremap K i<CR><Esc>k$

" Bye bye ex mode
noremap Q <NOP>

" redo
map U <C-r>

" sudo write
command! W w !sudo dd of=%

" to the end of the line (like C, D)
noremap Y y$"

nmap <silent> <BS> :nohlsearch<CR>

" no more shift on Lafayette
noremap , :

" F* keys

" find current word
map <silent> <F3> :execute "noautocmd Ack --ignore-dir=node_modules --ignore-dir=dist " . expand("<cword>")<CR>
map <silent> <F4> :execute "noautocmd Ack --ignore-dir=node_modules --ignore-dir=dist " . expand("<cWORD>")<CR>

map <silent> <F5> :call JsBeautify()<CR>

" emmet
map <silent> <F6> <C-y>,
imap <silent> <F6> <C-y>,

let g:AutoPairsShortcutToggle = '<F7>'

" nav through help tags
noremap <silent> <F9> <C-t>
noremap <silent> <F10> <C-]>

" the V, M and P marks are also available to reach the vimrc sections
map <silent> <F12> :tabedit $MYVIMRC<CR>
map <silent> <S-F12> :tabedit $VIMRUNTIME<CR>

" leaders

" keep it quite high for commentary - gcc - to work properly)
" set timeoutlen=400
map <Space> <Leader>

map <silent> <Leader><F1> :CtrlP<CR>
map <silent> <Leader><F2> :CtrlPBuffer<CR>

" free remaining letters for leader
" abcfimquyz
" ABCDFIMOQTUWYZ

" kakoune mode
map <silent> <Leader>u :execute "!kak % +" . line('.')<CR><CR>

" paste++
map <Leader>p "0p
map <Leader>P "0P

map <Leader>x :call NPMHome()<CR>
map <Leader>X :call NPMRegistry()<CR>

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

" windows
" move
" TODO: remove conflic with GitGutter causing <Leader>h to take 1sec
noremap <silent> <Leader>w :wincmd w<CR>
noremap <silent> <Leader>h :wincmd h<CR>
noremap <silent> <Leader>k :wincmd k<CR>
noremap <silent> <Leader>l :wincmd l<CR>
noremap <silent> <Leader>j :wincmd j<CR>
" rotate
noremap <Leader>H :wincmd H<CR>
noremap <Leader>K :wincmd K<CR>
noremap <Leader>L :wincmd L<CR>
noremap <Leader>J :wincmd J<CR>
" divide
noremap <Leader>s :wincmd s<CR>
noremap <Leader>v :wincmd v<CR>
" netrw
noremap <Leader>e :e.<CR>
noremap <Leader>E :Explore<CR>
noremap <Leader>S :Sexplore<CR>
noremap <Leader>V :Vexplore<CR>
" next Quickfix
noremap <Leader>o :cn<CR>

noremap <silent> <Leader>g :NERDTreeFind<CR>
noremap <silent> <Leader>G :NERDTreeToggle<CR>

" surround
map <Leader>' ysiw'
map <Leader>" ysiw"
map <Leader>( ysiw)
map <Leader>[ ysiw]
map <Leader>{ ysiw}
map <Leader>< ysiw>

" hardcore (see HardMode plugin)
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
" kakoune: use dl / dh instead, reserve x for the future
noremap x <NOP>
noremap X <NOP>
" noremap h <NOP>
" noremap l <NOP>

" easymotion
map s <Plug>(easymotion-prefix)

" indents
nmap <S-Tab> <<
nmap <Tab> >>
vmap <S-Tab> <gv
vmap <Tab> >gv
