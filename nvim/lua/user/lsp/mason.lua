-- nvim/lua/user/lsp/mason.lua

-- protected calls
local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local servers = {
  "ts_ls",
  "lua_ls",
  "pyright",
  "bashls",
}

-- Here we declare which settings to pass to the mason, and also ensure servers are installed. If not, they will be installed automatically.
local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

-- we'll need to call lspconfig to pass our server to the native neovim lspconfig.
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {
  -- getting "on_attach" and capabilities from handlers
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be caulled for each installed server that doesn't have
  -- a dedicated handler.

  function(server_name) -- optional default handler
    lspconfig[server_name].setup(opts)
  end,

  ["lua_ls"] = function()
    local lua_opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    }
    lspconfig["lua_ls"].setup(lua_opts)
  end,

  ["pyright"] = function()
    local pyright_opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
      cmd = {"pyright-langserver", "--max-old-space-size=3072", "--stdio"},
    }
    lspconfig["pyright"].setup(pyright_opts)
  end,

  --["gitlab_code_suggestions"] = function()
  --  local gitlab_opts = {
  --    on_attach = require("user.lsp.handlers").on_attach,
  --    capabilities = require("user.lsp.handlers").capabilities
  --  }
  --  lspconfig["gitlab_code_suggestions"].setup(gitlab_opts)
  --end
}

-- loop through the servers
--for _, server in pairs(servers) do
--
--  -- get the server name
--  server = vim.split(server, "@")[1]
--
--  --add any special configuration
--  if server == "lua_ls" then
--    opts['settings'] = {
--      Lua = {
--        diagnostics = {
--          globals = { 'vim' }
--        }
--      }
--    }
--  end
--  -- pass them to lspconfig
--  lspconfig[server].setup(opts)
--end
