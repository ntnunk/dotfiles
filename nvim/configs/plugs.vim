" plugs.vim
" Plugin Configuration for NeoVim
call plug#begin('~/.config/nvim/plugged') 
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'vimwiki/vimwiki'
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    Plug 'preservim/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-scripts/indentpython.vim'
    Plug 'tmhedberg/SimpylFold'
    Plug 'terryma/vim-multiple-cursors'
call plug#end()
