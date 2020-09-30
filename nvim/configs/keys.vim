" keys.vim
" Keymappings for NeoVim

" Map the <Leader> key to ','
let mapleader=','

" Map ESC to exit and close the terminal
tnoremap <Esc> <C-\><C-n>

" Navigate through splits with Ctrl+<regular nav keys (h,j,k,l)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" NERDCommenter
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" VimWiki
"<Leader>ww -- Open default wiki index file.
"<Leader>wt -- Open default wiki index file in a new tab.
"<Leader>ws -- Select and open wiki index file.
"<Leader>wd -- Delete wiki file you are in.
"<Leader>wr -- Rename wiki file you are in.
"<Enter> -- Follow/Create wiki link.
"<Shift-Enter> -- Split and follow/create wiki link.
"<Ctrl-Enter> -- Vertical split and follow/create wiki link.
"<Backspace> -- Go back to parent(previous) wiki link.
"<Tab> -- Find next wiki link.
"<Shift-Tab> -- Find previous wiki link.
