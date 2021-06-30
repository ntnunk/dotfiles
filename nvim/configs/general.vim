set encoding=utf-8
set number relativenumber               " Set hybrid line numbers (relative + ablosute at cursor)"
set nowrap                              " Don't wrap long lines
syntax on
set noswapfile
set scrolloff=7
set backspace=indent,eol,start
set shiftwidth=4
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set expandtab
set fileformat=unix
set cursorline
set noerrorbells
set hidden
set nobackup
set nowritebackup
set conceallevel=0                      " Don't hide chars in JSON, Markdown, etc
set iskeyword+=-                      	" treat dash separated words as a word text object
set mouse=a                             " Enable mouse use in normal and visual mode.

" Remap split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:python_host_prog='$HOME/.config/nvim/env2/bin/python'
let g:python3_host_prog='$HOME/.config/nvim/env3/bin/python'

" Automatically toggle between
"   - hybrid numbers in normal mode
"   - relative numbers in insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Text width at 80 columns for Markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

" Set up spelling and activate for Markdown
set spelllang=en_us
set spellfile=~/Dropbox/vim/spell.add
au BufRead,BufNewFile *.md setlocal spell

" Set tabs and whitespace to 2 for yaml, json, css, and HTML
autocmd FileType yaml,json,css,html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Set up Python formatting
au BufNewFile,BufRead *.py
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=0 |
    \ setlocal wrapmargin=0 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

