func! NixFmt()
	let view = winsaveview()

	:%!nixfmt
	if v:shell_error
		undo " Undo avoids replacing the buffer with the shell error message.
		echom "Undo after shell error executing nixfmt!"
	endif

	call winrestview(view)
endfunc

augroup nix
	autocmd!
	autocmd BufWritePre *.nix call NixFmt()
augroup END
