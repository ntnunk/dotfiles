"call plug#begin('~/.config/nvim/plugged')
call plug#begin('~/.local/share/nvim/plugged')

Plug 'autozimu/LanguageClient-neovim', {
\ 'branch': 'next',
\ 'do': 'bash install.sh',
\ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/echodoc.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'ervandew/supertab'

" Color themes
Plug 'kristijanhusak/vim-hybrid-material'

call plug#end()

let g:python_host_prog = '/home/noel/.config/nvim/env2/bin/python'
let g:python3_host_prog = '/home/noel/.config/nvim/env3/bin/python'

set hidden

let g:LanguageClient_serverCommands = { 
\ 'cpp': ['cquery', '--language-server', '--log-file=/tmp/cq.log'], 
\ 'c': ['cquery', '--language-server', '--log-file=/tmp/cq.log'], 
\ 'java': ['jdtls'],
\ }
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '/home/noel/.config/nvim/cquery_settings.json'

set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

function SetLSPShortcuts()
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
autocmd!
autocmd FileType cpp,c call SetLSPShortcuts()
augroup END

" Stuff I like
" Relative numbering
function! NumberToggle()
if(&relativenumber == 1)
set nornu
set number
else
set rnu
endif
endfunc

" Toggle relative number based on insert or normal mode
set number relativenumber
augroup numbertoggle
autocmd!
autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Use the system clipbboard
set clipboard=unnamed

filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set incsearch ignorecase smartcase hlsearch
set ruler laststatus=2 showcmd showmode
set list listchars=tab:▸▸,trail:·
set encoding=utf-8
set number "Line numbers on
set showmatch "Show matching brackets/parens/braces
set nojoinspaces "Prevents inserting two spaces after punctuation on a join (J)
set title
set splitbelow " Horizontal split below current.
set splitright " Vertical split right of current

" Enable mouse mode
set mouse=a

" Set transparency
let g:hybrid_transparent_background = 1

" NERDTree
let NERDTreeShowHidden = 1
let g:NERDTreeDirArrowExpandable = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'

" Airline
let g:airline_powerline_fonts = 1
let g:airline_section_z = ' %{strftime("%-I:%M %p")}'
let g:airline_section_warning = ''
"let g:airline#extensions#tabline#enabled = 1
" air-line
let g:airline_powerline_fonts = 1

" TagBar
let g:tagbar_width = 30
let g:tagbar_iconchars = ['↠', '↡']

" Supertab
" Sets default to start at the top, not the bottom.
let g:SuperTabDefaultCompletionType = "<C-n>"

" fzf-vim
let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-s': 'split',
\ 'ctrl-v': 'vsplit' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
\ 'bg':      ['bg', 'Normal'],
\ 'hl':      ['fg', 'Comment'],
\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':     ['fg', 'Statement'],
\ 'info':    ['fg', 'Type'],
\ 'border':  ['fg', 'Ignore'],
\ 'prompt':  ['fg', 'Character'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker':  ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header':  ['fg', 'Comment'] }

""" Filetype-Specific Configurations
" HTML, XML, Jinja
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango inoremap {{ {{  }}<left><left><left>
autocmd FileType htmldjango inoremap {% {%  %}<left><left><left>
autocmd FileType htmldjango inoremap {# {#  #}<left><left><left>

" Markdown and Journal
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2 spell
"autocmd FileType journal setlocal shiftwidth=2 tabstop=2 softtabstop=2 spell

" Double-height command window
set cmdheight=2
let g:deoplete#enable_at_startup = 1
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

" close preview window on leaving the insert mode
autocmd InsertLeave * if pumvisible() == 0 | pclose | endif

set signcolumn=yes

""" Custom Functions

" Trim Whitespaces
function! TrimWhitespace()
let l:save = winsaveview()
%s/\\\@<!\s\+$//e
call winrestview(l:save)
endfunction

" So we can toggle both NERDTree and Tagbar together.
" Call it 'IDE Mode'
function! ToggleSidebars()
:TagbarToggle
:NERDTreeToggle
endfunction

function! ColorHybrid()
" Hybrid Material Theme
" Matching Airline theme: hybrid
let g:airline_theme='hybrid'
set background=dark
color hybrid_material
highlight LineNr ctermfg=darkgray
let g:enable_bold_font=1
let g:enable_italic_font=1
let g:hybrid_transparent_background=1
endfunction

""" Custom key mappings

" Use , as the leader key
let mapleader=","

" Remap split navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" leader+, for NerdTree, w for Tagbar. \ for both
nmap <leader>q :NerdTreeToggle<cr>
nmap <leader>w :TagbarToggle<cr>
nmap \ :call ToggleSidebars()<cr>

" Leader+r to reload config
nmap <leader>r :so ~/.config/nvim/init.vim<cr>

" Use ,, to swap between buffers
nnoremap <leader><leader> :b#<cr>

call ColorHybrid()
