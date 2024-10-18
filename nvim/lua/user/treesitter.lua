local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {
    "c", "cmake", "cpp", "css", "dockerfile", "go", "hjson", "html", "java",
    "javascript", "json", "json5", "llvm", "lua", "make",
    "markdown", "python", "regex", "typescript", "vim", "yaml"
  },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml", "python" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  pyfold = {
    enable = true,
    custom_foldtext = true,
  }
}
