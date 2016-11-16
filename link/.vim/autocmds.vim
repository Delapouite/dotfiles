autocmd BufNewFile,BufReadPost *.ts set filetype=typescript

" files created by npm init follow this convention
autocmd BufReadPost package.json set expandtab shiftwidth=2 softtabstop=2 tabstop=2

" auto apply
augroup configurationFiles
	autocmd! BufWritePost vimrc source $MYVIMRC
	autocmd! BufWritePost .vimrc source $MYVIMRC
	autocmd! BufWritePost _vimrc source $MYVIMRC
	autocmd! BufWritePost Xresources !xrdb -load ~/.X/Xresources
augroup END
