return {
	"ahmedkhalf/project.nvim",
	config = function()
		local project = require("project_nvim")
		project.setup({
			active = true,
			on_config_done = nil,
			manual_mode = false, -- false allows setting of cwd automatically

			-- Next two options control how projects are identified
			detection_methods = { "pattern" },
			patterns = {
				".git",
				"_darcs",
				".hg",
				".bzr",
				".svn",
				"Makefile",
				"package.json",
			},

			show_hidden = false, -- show hidden files
			silent_chdir = true, -- Don't notify when changing CWD
			ignore_lsp = {}, -- list of LSP client names to ignore
			datapath = vim.fn.stdpath("data"), -- location to store project history
		})
	end,
}
