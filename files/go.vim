setlocal autowrite

let g:go_auto_type_info = 1  " FIXME: Not working!
let g:go_updatetime = 500  " FIXME: Not working!

" FIXME: For the life of me, I can't get these working!
let g:go_bin_path = $HOME . "/.nix-profile/bin"
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_auto_sameids = 1

" TODO: Remove this once above variables are being used properly.
augroup filetype_go
	autocmd!
	autocmd BufWritePre *.go GoImports
augroup end

nmap <leader>gb <Plug>(go-build)
nmap <leader>gd <Plug>(go-doc)
nmap <leader>gD <Plug>(go-doc-browser)
nmap <leader>gi <Plug>(go-info)
nmap <leader>gr <Plug>(go-run)
nmap <leader>gt <Plug>(go-test)

nmap <C-]> <Plug>(go-def)
