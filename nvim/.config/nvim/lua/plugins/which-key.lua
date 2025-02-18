return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>c", group = "Code" },
			{ "<leader>e", group = "Explorer" },
			{ "<leader>f", group = "Files" },
			{ "<leader>g", group = "Git" },
			{ "<leader>s", group = "Search/Replace" },
			{ "<leader>t", group = "To-Do" },
			{ "<leader>v", group = "View" },
			{ "<leader>w", group = "Workspace (Session)" },
		},
	},
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
}
