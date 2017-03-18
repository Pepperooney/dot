set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

set hlsearch

:nmap <C-N><C-I> :set invrelativenumber<CR>
:nmap <C-N><C-N> :set invnumber<CR>

set laststatus=2

set t_Co=256
colorscheme atom-dark-256

filetype on
filetype plugin on

autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

syntax on

" csv plugin
hi CSVColumnEven        ctermbg=0 ctermfg=10
hi CSVColumnOdd         ctermbg=0 ctermfg=14
hi CSVColumnHeaderEven  ctermbg=0 ctermfg=2
hi CSVColumnHeaderOdd   ctermbg=0 ctermfg=6
