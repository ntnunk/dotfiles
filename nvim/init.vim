
source $HOME/.config/nvim/configs/plugs.vim
source $HOME/.config/nvim/configs/general.vim
source $HOME/.config/nvim/configs/colors.vim
source $HOME/.config/nvim/configs/keys.vim
source $HOME/.config/nvim/configs/coc_config.vim

"VimWiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

"NERDTree
let NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=1
nmap <F2> :NERDTreeToggle<CR>

