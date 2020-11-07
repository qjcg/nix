"func! CueFmt()
"	let view = winsaveview()
"
"	:%!cue fmt -s
"	if v:shell_error
"		undo " Undo avoids replacing the buffer with the shell error message.
"		echom "Undo after shell error executing `cue fmt`!"
"	endif
"
"	call winrestview(view)
"endfunc
"
"augroup cue
"	autocmd!
"	autocmd FileType cue autocmd BufWritePre <buffer> call CueFmt()
"augroup END
