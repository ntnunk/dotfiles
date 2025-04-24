return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
      auto_restore = false,
			auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "~/Documents" },
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for CWD" })
		keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for autos session root dir" })
    keymap.set("n", "<leader>wf", "<cmd>SessionSearch<CR>", { desc =  "Find session" })
	end,
}
