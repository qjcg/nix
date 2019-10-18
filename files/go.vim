" Settings for GO + vim
" References:
"   - https://octetz.com/posts/vim-as-go-ide

setlocal autowrite
autocmd BufWritePre *.go CocCommand editor.action.organizeImport

" disable vim-go :GoDef short cut (gd)
" this is handled by COC LanguageClient [LC]
let g:go_def_mapping_enabled = 0
