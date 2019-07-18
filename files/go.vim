setlocal autowrite

let g:go_auto_type_info = 1  " FIXME: Not working!
let g:go_bin_path = $HOME . "/.nix-profile/bin"
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

nmap <leader>gb <Plug>(go-build)
nmap <leader>gd <Plug>(go-doc)
nmap <leader>gD <Plug>(go-doc-browser)
nmap <leader>gi <Plug>(go-info)
nmap <leader>gr <Plug>(go-run)
nmap <leader>gt <Plug>(go-test)

" FIXME: (go-def) not working (bug :GoDef is!!)
nmap CTRL-] <Plug>(go-def)

call tagbar#autoopen(1)
