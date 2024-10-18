--vim.opt.termguicolors = true
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldcolumn = "0"
-- vim.opt.foldtext = ""
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
-- vim.opt.foldnestmax = 4
vim.opt.foldenable = false

require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.dap"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.project"
require "user.impatient"
require "user.indentline"
require "user.alpha"
require "user.whichkey"
require "user.autocommands"

vim.keymap.set('n', '<C-g>', '<Plug>(GitLabToggleCodeSuggestions)')

-- Suppress some annoying and useless Vim Notify messages
local notify = vim.notify
vim.notify = function(msg, ...)
  if msg:match("warning: multiple different client offset_encodings") then
    return
  elseif msg:match("gitlab.vim: Workspace configuration changed") then
    return
  elseif msg:match("gitlab.vim: Subscribing client") then
    return
  elseif msg:match("LSP[gitlab_code_suggestions]") then
    return
  end

  notify(msg, ...)
end
