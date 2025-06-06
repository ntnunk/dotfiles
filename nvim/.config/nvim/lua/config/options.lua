-- Disable net_rw since NVim Tree will replace it.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.tabstop = 4 -- 4 spaces for tabs
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new
opt.wrap = false
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if mixed case is search, assume case-sensitive
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes" -- show sign column always so text won't shift
opt.backspace = "indent,eol,start" -- allow backspace on indent, EOL or insert mode start position
opt.clipboard:append("unnamedplus") -- System clipboard as default register
opt.splitright = true -- split vertical windows to the right
opt.splitbelow = true -- split horizontal to the bottom
opt.backup = false -- creates a backup file
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
opt.colorcolumn = "80"
opt.conceallevel = 1
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.hlsearch = false -- highlight all matches on previous search pattern
opt.incsearch = true
opt.ignorecase = true -- ignore case in search patterns
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.pumheight = 10 -- pop up menu height
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 0 -- always show tabs
opt.smartcase = true -- smart case
opt.smartindent = true -- make indenting smarter again
opt.swapfile = false -- creates a swapfile
opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.ttimeoutlen = 0 -- keycode delays. If omitted, timoutlen above can break <leader>
opt.undofile = true -- enable persistent undo
opt.updatetime = 300 -- faster completion (4000ms default)
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.tabstop = 2 -- insert 2 spaces for a tab
opt.cursorline = true -- highlight the current line
opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.numberwidth = 4 -- set number column width to 2 {default 4}
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.wrap = false -- display lines as one long line
opt.scrolloff = 8 -- is one of my fav
opt.sidescrolloff = 8
opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
opt.completeopt = 'menu,menuone'
