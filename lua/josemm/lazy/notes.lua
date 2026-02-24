return {
	"itsvinayak/nvim-notes.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim", -- Add Telescope as a dependency
		"folke/which-key.nvim", -- Add WhichKey as a dependency (optional)
	},
	config = function()
		require("notes").setup({
			-- Optional configurations
			path = "~/.notes", -- Custom path for notes (default is '~/.notes')
			log_enabled = true, -- Enable logging (default is false)
			log_level = "INFO", -- Set log level to INFO
			filetype = "md", -- Sets the notes filetype default is 'md'
		})

		vim.api.nvim_set_keymap("n", "<leader>nw", ":Notes write<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>nf", ":Notes find<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>ng", ":Notes get<CR>", { noremap = true, silent = true })
	end,
}
