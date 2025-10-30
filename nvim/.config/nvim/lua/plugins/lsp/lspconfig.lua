return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client == nil then
          return
        end
        -- if client.name == "ruff" then
        --   -- disable hover in favor of pyright
        --   client.server_capabilities.hoverProvider = false
        -- end

				local opts = { buffer = ev.buf, silent = true }
				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "Show references"
				keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "See available Code Actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>cD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts)

        opts.desc = "Jump to next diagnostic error"
        keymap.set("n", "<leader>cn", vim.diagnostic.goto_next, opts)

        opts.desc = "Jump to previous diagnostic error"
        keymap.set("n", "<leader>cp", vim.diagnostic.goto_next, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "]d", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>cl", ":LspRestart<CR>", opts)

			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()
		local signs = { Error = "", Warn = "", Info = "", Hint = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

    lspconfig.ruff.setup({
      init_options = {
        settings = {
          showSyntaxErrors = true,
          logLevel = "info",
          args = { "--config", "~/.config/ruff.toml"},
          interpreter = "/usr/bin/env python3",
        },
      }
    })

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the ls recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
      -- ["pyright"] = function()
      --   lspconfig["pyright"].setup({
      --     capabilities = capabilities,
      --     settings =  {
      --       pyright = {
      --         -- Using Ruff's import organizer
      --         disableOrganizeImports = true,
      --       },
      --       python = {
      --         analysis = {
      --           autoSearchPaths = true,
      --           diagnosticMode = 'workspace',
      --           useLibraryCodeForTypes = true,
      --           extraPaths = {
      --             '/home/fortress/workspace/repos/m32rimm/fis_common'
      --           },
      --           ignore = { '*' },
      --         },
      --       },
      --     },
      --   })
      -- end,
      ["basedpyright"] = function()
        lspconfig["basedpyright"].setup({
          capabilities = capabilities,
          settings =  {
            basedpyright = {
              disableOrganizeImports = true,
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                useLibraryCodeForTypes = false,
                typeCheckingMode = 'basic',
                diagnosticMode = 'workspace',
                autoSearchPath = true,
                autoFormatStrings = true,
                exclude = {
                  "**/__pycache__",
                  "**/node_modules",
                  "**/.venv",
                  "**/venv",
                  "**/.pytest_cache",
                  "**/build",
                  "**/dist"
                },
                diagnosticSeverityOverrides = {
                  reportMissingTypeArgument = false,
                },
                -- Suppress "partially unknown type" warnings
                reportUnknownParameterType = 'none',
                reportUnknownVariableType = 'none',
                reportUnknownMemberType = 'none',
                reportUnknownArgumentType = 'none',
                extraPaths = {
                  '/home/fortress/workspace/virtenv312/lib/python3.12/site-packages',
                  '/home/fortress/workspace/repos/m32rimm/fis_common',
                  '/home/fortress/workspace/repos/m32rimm/fisio',
                  '/home/fortress/workspace/repos/m32rimm/clustereng_tools',
                  '/home/fortress/workspace/repos/m32rimm/fix_tools',
                  '/home/fortress/workspace/repos/m32rimm/fortress_api',
                  '/home/fortress/workspace/repos/m32rimm/fptest_module',
                  '/home/fortress/workspace/repos/m32rimm/email_tools',
                }
              },
            },
            python = {
              pythonPath = '/home/fortress/workspace/virtenv312/bin/python',
              venvPath = '/home/fortress/workspace',
              venv = 'virtenv312',
            }
          },
        })
      end,

		})

    -- vim.keymap.set(
    --   "n", "<leader>ch",
    --   "<cmd>lua vim.lsp.inlay_hint.enable(vim.lsp.inlay_hint.is_enabled())<CR>",
    --   { desc = "Toggle LSP Inlay Hints" }
    -- )
	end,
}
