if v:version < 802
    packadd! dracula
endif
syntax enable
colorscheme dracula

"user recommended from defaults.vim
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set encoding=utf-8
set noswapfile
set ruler
set ignorecase
set nohlsearch
set incsearch
set rnu

set expandtab           " use spaces for indentation instead of tab charactes
set softtabstop=2       " number of spaces for each <Tab> keypress
set shiftwidth=2        " number of spaces for auto-indentation
set shiftround          

set textwidth=79

set colorcolumn=80

" ALE settings 
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '>>'

let g:ale_lint_on_text_change = 'never'
let g:ale_lint_on_insert_leave = 'true'
let g:ale_linters = {'bash': ['shellcheck'],}

" Remaps
imap jj <ESC>
nmap confe :e ~/.vimrc<CR>
nmap so :source ~/.vimrc<CR>
nnoremap <C-U> <C-U>zz  " center page on page up
nnoremap <C-D> <C-D>zz  " center page on page down
nnoremap n nzzzv
nnoremap N Nzzv

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" buffer naviagation
nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>
nnoremap gb :ls<CR>:b<Space>

" Mouse support
set mouse=a
set ttymouse=sgr
set balloonevalterm

