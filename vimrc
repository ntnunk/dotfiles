" Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"git interface
Plugin 'tpope/vim-fugitive'

"filesystem
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim' 

" Twitter client
Plugin 'twitvim/twitvim.git'

" Vimwiki
Plugin 'mattn/calendar-vim'
Plugin 'vimwiki/vimwiki'

" Surround for working with quotes, brackets, etc
Plugin 'tpope/vim-surround'

" Autoclose HTML tags
"Plugin 'vim-scripts/closetag.vim'

" Autocomplete brackets, braces, and parens
"Plugin 'Townk/vim-autoclose'

" html
" isnowfy only compatible with python not python3
Plugin 'isnowfy/python-vim-instant-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'nelstrom/vim-markdown-preview'

" python sytax checker
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/Pydiction'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'

" Git stuff
Plugin 'airblade/vim-gitgutter'

" auto-completion stuff
" Plugin 'klen/python-mode'
Plugin 'Valloric/YouCompleteMe'
Plugin 'klen/rope-vim'

" Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'

" code folding
Plugin 'tmhedberg/SimpylFold'

" UltiSnips
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine.
Plugin 'honza/vim-snippets'

" Tagbar instead of taglist
Plugin 'majutsushi/tagbar'

if has('nvim')
    "NeoVim doesn't support Powerline so use Airline instead
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    let g:airline_theme='angr'
else
    " Regular Vim, use Powerline
    set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
    " Always show statusline
    set laststatus=2
    " Use 256 colours (Use this setting only if your terminal supports 256 colours)
    set t_Co=256
endif

"Colors!!!
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'
Plugin 'philpl/vim-adventurous'
Plugin 'chriskempson/tomorrow-theme'
Plugin 'sickill/vim-monokai'
Plugin 'andbar-ru/vim-unicon'
Plugin 'xero/blaquemagick.vim'
Plugin 'josuegaleas/jay'
Plugin 'whatyouhide/vim-gotham'
Plugin 'tomsik68/vim-crystallite'
Plugin 'hhsnopek/vim-firewatch'
Plugin 'owickstrom/vim-colors-paramount'
Plugin 'limadm/vim-blues'
Plugin 'tristanheaven/vim-colorscheme-aquamarine'
Plugin 'lanox/lanox-vim-theme'

call vundle#end()

" Stop complaining about unsaved buffers when switching.
set hidden

filetype plugin indent on    " enables filetype detection
let g:SimpylFold_docstring_preview = 1

" autocomplete
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" Pydiction dictionary location
let g:pydiction_location = 'home/noel/.vim/bundle/Pydiction/complete_dict'

" custom keys
let mapleader=","
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Toggle NerdTree
nmap <F8> :NERDTreeToggle<CR>

" Toggle Tagbar
nmap <F9> :TagbarToggle<CR>

set background=dark
colorscheme sweyla-aqua

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" I don't like swap files
set noswapfile

" HTML editing
set matchpairs+=<:>

" UltiSnips stuff
" Trigger Confiuration. <tab> conflicts with YouCompleteMe
let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsListSnippets="<c-s-tab>"

" Let :UltiSnipsEdit split the window
let g:UltiSnipsEditSplit="vertical"

" Softtabs, 2 spaces
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Make it obvious where 100 chars is
set textwidth=100

" Enable the mouse to work with tmux
set mouse=a

" Scrolling
set scrolloff=8 " Start scrolling 8 lines from margin
set sidescrolloff=15
set sidescroll=1

" Toggle relative numbering, and set to absolute
" on loss of focus or insert mode
set rnu
function! ToggleNumbersOn()
  set number
  set norelativenumber
endfunction
function! ToggleRelativeOn()
  set relativenumber
  set nonumber
endfunction
function! ToggleMixNumbers()
  set number
  set relativenumber
endfunction
autocmd FocusLost * call ToggleNumbersOn()
autocmd FocusGained * call ToggleMixNumbers()
autocmd InsertEnter * call ToggleNumbersOn()
autocmd InsertLeave * call ToggleMixNumbers()

" Show the filename in Tmux
autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window 'vim | " . expand("%:t") . "'")
autocmd VimLeave * call system("tmux rename-window 'tmux'")

" vimwiki stuff
" Run multiple wikis
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/', 'syntax': 'markdown', 'ext': '.wiki'}]

au BufRead,BufNewFile *.wiki set filetype=vimwiki
:autocmd FileType vimwiki map D :VimwikiMakeDiaryNote
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
:autocmd FileType vimwiki map C :call ToggleCalendar()

" python with virtualenv support
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  sys.path.insert(0, project_base_dir)
  activate_this = os.path.join(project_base_dir,'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" it would be nice to set tag files by the active virtualenv here
" :set tags=~/mytags "tags for ctags and taglist
" omnicomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete

"------------Start Python PEP 8 stuff----------------
" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h,*.ino,*.pde set tabstop=4

" spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py,*.pyw set softtabstop=4

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/

" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.ino,*.pde match BadWhitespace /\s\+$/

" Auto-delete trailing whitespace for file types
autocmd FileType c,cpp,java,php,py,pyw,ino,pde autocmd BufWritePre <buffer> %s/\s\+$//e

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=100

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h,*.ino,*.pde set fileformat=unix

" Set the default file encoding to UTF-8:
set encoding=utf-8

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Keep indentation level from previous line:
autocmd FileType python set autoindent

" make backspaces more powerful
set backspace=indent,eol,start

" Folding based on indentation:
autocmd FileType python setlocal foldmethod=indent smartindent shiftwidth=4 ts=4 et cinwords=if,elif,else,for,while,try,except,finally,def,class
set foldlevel=99

" use space to open folds
nnoremap <space> za 
"----------Stop python PEP 8 stuff--------------

" js stuff"
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

" Proper handling of Arduino files
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp

" Remove background set by theme
highlight Normal ctermbg=none
highlight NonText ctermbg=none
if has('nvim')
    highlight Normal guibg=none
    highlight NoneText guibg=none
endif

" Clear the gitgutter and line number bars
highlight clear SignColumn
highlight clear LineNr
highlight clear TagBar

