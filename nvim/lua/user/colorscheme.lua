local colorscheme = "onedark"

if colorscheme == "tokyonight" then
  vim.g.tokyonight_style = "storm"
  vim.g.tokyonight_transparent = true
  vim.g.tokyonight_transparent_sidebar = true
  vim.g.tokyonight_dark_sidebar = true
  vim.g.tokyonight_dark_float = true
  vim.g.tokyonight_italic_keywords = false
elseif colorscheme == "ayu" then
  vim.g.ayucolor="mirage"
elseif colorscheme == "darkplus" then
  --vim.cmd [[
  --  hi Normal guibg=#1E2127
  --]]
  --vim.cmd [[
  --  hi MsgArea guibg=#1E2127
  --]]
elseif colorscheme == "onedark" then
  require('onedark').setup {
    style = 'darker',
    transparent = false,
    term_colors = false,
    ending_tildes = false,
    cmp_itemkind_reverse = false,
    toggle_style_key = '<leader>ts',
    toggle_style_list = {
      'dark', 'darker', 'cool', 'deep',
      'warm', 'warmer', 'light'
    },
    code_style = {
      comments = 'italic',
      keywords = 'none',
      functions = 'none',
      strings = 'none',
      variables = 'none'
    },
    colors = {},
    highlights = {},
    diagnostics = {
      darker = true,
      undercurl = true,
      background = true,
    }
  }
elseif colorscheme == "github" then
  require('github-theme').setup {
    theme_style = "dark",
    colors = {},
    comment_style = "italic",
    dark_float = false,
    dark_sidebar = true,
    dev = false,
    function_style = nil,
    hide_end_of_buffer = true,
    hide_inactive_statusline = true,
    keyword_style = "italic",
    msg_area_stlye = nil,
    sidebars = {},
    transparent = true,
    variable_style = nil,
  }
end

colorscheme_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not colorscheme_ok then
  vim.notify("Coloscheme " .. colorscheme .. " was not found. Setting default.")
  return
end


--vim.cmd [[
--try
--  colorscheme darkplus
--catch /^Vim\%((\a\+)\)\=:E185/
--  colorscheme default
--  set background=dark
--endtry
--]]
