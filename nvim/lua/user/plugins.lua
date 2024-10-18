local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	-- use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "nvim-tree/nvim-web-devicons",
	})
	use({
		"akinsho/bufferline.nvim",
		tag = "v4.*",
	})
	use("moll/vim-bbye")
	use("nvim-lualine/lualine.nvim")
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use({
    "folke/which-key.nvim",
    tag = "v1.6.1"
  })
	use({
		"ur4ltz/surround.nvim",
		config = function()
			require("surround").setup({
				mappings_style = "surround",
			})
		end,
	})
	use({
    "kdheepak/lazygit.vim",
    -- optional for floating window border decoration
    requires = {
      "nvim-lua/plenary.nvim"
    },
  })

	-- Colorschemes
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	use("lunarvim/darkplus.nvim")
	use("folke/tokyonight.nvim")
	--use {
	--  "arcticicestudio/nord-vim",
	--  tag = "*",
	--}
	use("cocopon/iceberg.vim")
	use("ayu-theme/ayu-vim")
	use("EdenEast/nightfox.nvim")
	use("navarasu/onedark.nvim")
	use("projekt0n/github-nvim-theme")
	use("shaunsingh/nord.nvim")

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- -- Gitlab code completion
	--vim.env.GITLAB_VIM_URL = "https://gitlab.com"
	--use {
	--  "git@gitlab.com:gitlab-org/editor-extensions/gitlab.vim.git",
	--  config = function()
	--    local opts = {
	--      force = true,
	--      prompt_user = true,
	--      output_encoding = 'utf-8',
	--    }
	--    require('gitlab').setup(opts)
	--  end
	--}

	-- LSP
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		tag = "v2.9.1",
		config = function()
			require("trouble").setup({
				mode = "document_diagnostics",
			})
		end,
	})

	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			local opts = {
				auto_preview = false,
				show_numbers = true,
				show_relative_numbers = true,
				autofold_depth = 2,
				keymaps = {
					close = "q",
				},
			}
			require("symbols-outline").setup(opts)
		end,
	})

	-- git-conflict
	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
		config = function()
			require("git-conflict").setup()
		end,
	})

	-- Harpoon
	use("ThePrimeagen/harpoon")

	-- Telescope
	use("nvim-telescope/telescope.nvim")

	-- Treesitter
	use("eddiebergman/nvim-treesitter-pyfold")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	--use "JoosepAlviste/nvim-ts-context-commentstring"

	-- Git
	use({
    "lewis6991/gitsigns.nvim",
    tag = "v0.8.1"
  })
	use("tpope/vim-fugitive")

	-- Python Auto-import
	use("tjdevries/apyrori.nvim")

	-- Debugging
	use("mfussenegger/nvim-dap")
	use("mfussenegger/nvim-dap-python")
	use("rcarriga/nvim-dap-ui")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
