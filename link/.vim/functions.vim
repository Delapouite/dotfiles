" use :W to sudo-write the current buffer
command! W w !sudo tee % > /dev/null

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
