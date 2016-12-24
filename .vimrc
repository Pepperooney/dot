set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

set showbreak=↪

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
let g:csv_no_column_highlight = 1
