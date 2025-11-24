return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			local oil = require("oil")
			oil.setup({
				lsp_file_methods = {
					enabled = true,
					timeout_ms = 1000,
					autosave_changes = false,
				},
				keymaps = {
					["<C-v>"] = { "actions.select", opts = { vertical = true } },
					["<C-s>"] = { "actions.select", opts = { horizontal = true } },
				},
				keymaps_help = {
					border = "rounded",
				},
				win_options = {
					signcolumn = "yes:2",
				},
			})
			vim.keymap.set("n", "<leader>fe", oil.open, { desc = "Open Oil File Explorer" })
		end,
	},
	{
		"JezerM/oil-lsp-diagnostics.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {},
		config = function()
			require("oil-lsp-diagnostics").setup({
				diagnostic_colors = {
					error = "DiagnosticError",
					warn = "DiagnosticWarn",
					info = "DiagnosticInfo",
					hint = "DiagnosticHint",
				},
				diagnostic_symbols = {
					error = "✘",
					warn = "▲",
					hint = "⚑",
					info = "»",
				},
			})
		end,
	},
}
