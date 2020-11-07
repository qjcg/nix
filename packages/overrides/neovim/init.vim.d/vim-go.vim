" Settings for GO + vim
" For inspiration, see:
"   - https://octetz.com/posts/vim-as-go-ide

setlocal autowrite

" See :h 'g:go_fmt_autosave'
let g:go_fmt_autosave = 1
let g:go_imports_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_imports_mode = 'goimports'

let g:go_def_mode  ='gopls'
let g:go_def_mapping_enabled = 0  " disable vim-go :GoDef short cut (gd), this is handled by COC LanguageClient [LC]
let g:go_info_mode ='gopls'
let g:go_auto_type_info = 1

let g:go_metalinter_autosave = 1
let g:go_metalinter_command = 'golangci-lint'

" LINTING
" See output of `golangci-lint linters` for available linters.

" These linters are run **automatically on file save** (when 'g:go_metalinter_autosave = 1').
let g:go_metalinter_autosave_enabled = [
	\	'golint',
	\	'gosimple',
	\	'govet',
\ ]

" These linters are run when :GoMetaLinter is **invoked manually**.
let g:go_metalinter_enabled = [
	\ 'deadcode',
	\ 'errcheck',
	\ 'goimports',
	\ 'golint',
	\ 'gosimple',
	\ 'govet',
	\ 'ineffassign',
	\ 'staticcheck',
	\ 'structcheck',
	\ 'typecheck',
	\ 'unused',
	\ 'varcheck',
\ ]
