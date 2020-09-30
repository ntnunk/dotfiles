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
