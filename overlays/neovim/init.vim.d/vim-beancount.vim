" See https://github.com/nathangrigg/vim-beancount/blob/master/doc/beancount.txt

let g:beancount_separator_col=75

" Automatically align commodities every time you type a decimal point.
inoremap . .<C-\><C-O>:AlignCommodity<CR>
