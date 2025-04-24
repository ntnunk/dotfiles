return {
	"akinsho/git-conflict.nvim",
	version = "*",
  lazy = false,
  opts = {
    default_mappings = false,
    on_attach = function(bufnr)
      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { desc = desc })
      end
      map("n", "<leader>gcn", "<cmd>GitConflictNextConflict<cr>", "Next Conflict")
      map("n", "<leader>gcp", "<cmd>GitConflictPrevConflict<cr>", "Previous Conflict")
      map("n", "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", "Choose Ours")
      map("n", "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", "Choose Theirs")
      map("n", "<leader>gct", "<cmd>GitConflictChooseBoth<cr>", "Choose Both")
    end,
  }
}
