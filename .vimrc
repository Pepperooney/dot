set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

set showbreak=↪

:nmap <C-N><C-I> :set invrelativenumber<CR>
:nmap <C-N><C-N> :set invnumber<CR>

set laststatus=2

set t_Co=256
colorscheme atom-dark-256
syntax on

filetype on
filetype plugin on

autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
