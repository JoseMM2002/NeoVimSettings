return {
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				panel = { enabled = false },
				suggestion = {
					enabled = true,
					auto_trigger = false,
					trigger_on_accept = true,
					keymap = {
						accept = "<C-j>",
						next = "<C-n>",
						prev = "<C-p>",
						dismiss = "<C-e>",
					},
				},
				markdown = true,
				help = true,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuOpen",
				callback = function()
					require("copilot.suggestion").dismiss()
					vim.b.copilot_suggestion_hidden = true
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuClose",
				callback = function()
					vim.b.copilot_suggestion_hidden = false
				end,
			})
		end,
	},
}
