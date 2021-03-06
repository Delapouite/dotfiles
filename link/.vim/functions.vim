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

" nnoremap <silent> 0 :call ToggleMovement('^', '0')<CR>
function! ToggleMovement(firstOp, thenOp)
	let pos = getpos('.')
	execute "normal! " . a:firstOp
	if pos == getpos('.')
		execute "normal! " . a:thenOp
	endif
endfunction

" split window if mode to border
function! WinMove(key)
	let t:curwin = winnr()
	exec "wincmd ".a:key
	if (t:curwin == winnr()) " Already at border
		if (match(a:key,'[jk]')) " Figure out direction
			wincmd v
		else
			wincmd s
		endif
		exec "wincmd ".a:key
	endif
endfunction

function! AddEmptyLineBelow()
	call append(line("."), "")
endfunction

function! AddEmptyLineAbove()
	let l:scrolloffsave = &scrolloff
	" Avoid jerky scrolling with ^E at top of window
	set scrolloff=0
	call append(line(".") - 1, "")
	if winline() != winheight(0)
		silent normal! <C-e>
	end
	let &scrolloff = l:scrolloffsave
endfunction

function! DelEmptyLineBelow()
	if line(".") == line("$")
		return
	end
	let l:line = getline(line(".") + 1)
	if l:line =~ '^\s*$'
		let l:colsave = col(".")
		.+1d
		''
		call cursor(line("."), l:colsave)
	end
endfunction

function! DelEmptyLineAbove()
	if line(".") == 1
		return
	end
	let l:line = getline(line(".") - 1)
	if l:line =~ '^\s*$'
		let l:colsave = col(".")
		.-1d
		silent normal! <C-y>
		call cursor(line("."), l:colsave)
	end
endfunction

" deal with NPM

function! NPMGetPackage ()
	let pkg = expand('<cWORD>')
	" remove surrounding quotes and potentian colon
	return matchstr(pkg, '\([-a-zA-Z]\+\)')
endfun

function! NPMHome ()
	silent exec '!npm home ' . NPMGetPackage()
endfun

function! NPMRegistry ()
	silent exec '!xdg-open https://www.npmjs.com/package/' . NPMGetPackage()
endfun

" linewise - characterwise converter
function! Paste(regname, pasteType, pastecmd)
	let reg_type = getregtype(a:regname)
	call setreg(a:regname, getreg(a:regname), a:pasteType)
	exe 'normal "'.a:regname . a:pastecmd
	call setreg(a:regname, getreg(a:regname), reg_type)
endfunction

autocmd VimEnter * command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%', '?'),
  \                 <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)
