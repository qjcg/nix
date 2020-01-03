" Settings for GO + vim
" References:
"   - https://octetz.com/posts/vim-as-go-ide
setlocal autowrite
autocmd BufWritePre *.go :GoImports

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" disable vim-go :GoDef short cut (gd)
" this is handled by COC LanguageClient [LC]
let g:go_def_mapping_enabled = 0
