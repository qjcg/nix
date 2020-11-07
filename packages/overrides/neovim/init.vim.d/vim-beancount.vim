" See https://github.com/nathangrigg/vim-beancount/blob/master/doc/beancount.txt

let g:beancount_detailed_first = 1  " (default 0)  If non-zero, accounts higher down the hierarchy will be listed first as completions.
let g:beancount_separator_col = 75  " (default 50) The column that the decimal separator is aligned to.

" FIXME: Reimplement AlignCommodity behavior as an **ftplugin**.
" See https://vim.fandom.com/wiki/File_type_plugins

" Automatically align commodities every time you type a decimal point.
"inoremap . .<C-\><C-O>:AlignCommodity<CR>
