return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
        file_ignore_patterns = {
          "./archive/*",
          "archive",
          "^archive/",
          "archive/*",
        },
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		local keymap = vim.keymap
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy find files in CWD" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "Find string in CWD" })
		keymap.set("n", "<leader>ss", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor in CWD" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find To-Dos" })
    keymap.set("n", "<leader>cs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "List all document symbols" })
    keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { desc = "List all current buffers" })
    keymap.set("n", "<leader>bf", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Fuzzy-find within the current buffer" })
    keymap.set("n", "<leader>sm", "<cmd>Telescope marks<CR>", { desc = "Show/search current list of Vim marks" })
	end,
}
