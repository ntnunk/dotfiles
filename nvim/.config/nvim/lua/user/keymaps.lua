local opts = { noremap = true, silent = true }

--local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable EX mode since I'm always hitting Q by mistake
keymap("", "Q", "<Nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move blocks of text up/down in Visua mode, respecting indent
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Maintain cursor position when appending lines with 'J'
keymap("n", "J", "mzJ`z", opts)

-- Keep cursor vertically centered while half-page jumping with <Ctrl-D>/<Ctrl-U>
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Keep cursor vertically centered when jumping through search terms
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- <Leader-s> Start replace command with current word under cursor
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

vim.cmd([[
let g:vimspector_sidebar_width = 85
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 70
]])

vim.cmd([[
  nmap <F9> <cmd>call vimspector#Launch()<cr>
  nmap <F5> <cmd>call vimspector#StepOver()<cr>
  nmap <F8> <cmd>call vimspector#Reset()<cr>
  nmap <F11> <cmd>call vimspector#StepOver()<cr>")
  nmap <F12> <cmd>call vimspector#StepOut()<cr>")
  nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])
keymap("n", "Db", ":call vimspector#ToggleBreakpoint()<cr>", opts)
keymap("n", "Db", ":call vimspector#AddWatch()<cr>", opts)
keymap("n", "Db", ":call vimspector#Evaluate()<cr>", opts)
keymap("n", "<leader>tn", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2, zsh <CR> ", opts)
keymap('n', "tt", ":FloatermToggle myfloat<CR>", opts)
keymap('t', "<Esc>", "<C-\\><C-n>:q<CR>", opts)

