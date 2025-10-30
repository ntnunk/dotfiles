if vim.g.vscode then
  -- This is Neovim running inside VSCode's vscode-nvim plugin
  require("config.options")
  require("config.keymaps")
else
  require("config")
end
