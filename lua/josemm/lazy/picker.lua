return {
	{
		"folke/snacks.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "tpope/vim-fugitive" },
		},
		keys = {
			{
				"<leader>ff",
				function()
					Snacks.picker.files({ hidden = true, ignored = false })
				end,
				desc = "Find files",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers({ sort_lastused = true })
				end,
				desc = "Find buffers",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.command_history({})
				end,
				desc = "Commands",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.grep({})
				end,
				desc = "Live grep",
			},
			{
				"<leader>fR",
				function()
					Snacks.picker.grep_buffers({})
				end,
				desc = "Recent files",
			},
			{
				"<leader>fm",
				function()
					Snacks.picker.marks({})
				end,
				desc = "Marks",
			},
			{
				"<leader>fh",
				function()
					Snacks.picker.help({})
				end,
				desc = "Help",
			},
			{
				"<leader>fS",
				function()
					Snacks.picker.git_status({})
				end,
				desc = "Git status",
			},
			{
				"<leader>fD",
				function()
					Snacks.picker.diagnostics({})
				end,
				desc = "Diagnostics (workspace)",
			},
			{
				"<leader>fd",
				function()
					Snacks.picker.diagnostics_buffer({})
				end,
				desc = "Diagnostics (buffer)",
			},
			{
				"<leader>fs",
				function()
					Snacks.picker.lsp_symbols({})
				end,
				desc = "Symbols",
			},
			{
				"gr",
				function()
					Snacks.picker.lsp_references({})
				end,
				desc = "LSP refs",
			},
			{
				"gd",
				function()
					Snacks.picker.lsp_definitions({})
				end,
				desc = "LSP defs",
			},
			{
				"<leader>fC",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "Colorschemes",
			},
			{
				"<leader>fN",
				function()
					Snacks.picker.registers()
				end,
				desc = "Registers",
			},
			{
				"<leader>fu",
				function()
					Snacks.picker.undo()
				end,
				desc = "Undo history",
			},
			{
				"<leader>fp",
				function()
					Snacks.picker.gh_pr()
				end,
				desc = "GitHub pull requests",
			},
			{
				"<leader>fn",
				function()
					vim.cmd("SnacksNotifications")
				end,
				desc = "Notifications",
			},
		},
		config = function()
			require("snacks").setup({
				gh = {
					-- your gh configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				},
				input = { enabled = true },
				picker = {
					enabled = true,
					matcher = { smart_case = true, fuzzy = true },
					sources = {
						gh_issue = {
							-- your gh_issue picker configuration comes here
							-- or leave it empty to use the default settings
						},
						gh_pr = {
							-- your gh_pr picker configuration comes here
							-- or leave it empty to use the default settings
						},
					},
				},
			})
		end,
	},
	{
		"JoseMM2002/snacks-nvim-notify",
		dependencies = { "folke/snacks.nvim", "rcarriga/nvim-notify" },
		config = function()
			require("snacks-nvim-notify").setup({
				width = 0.6,
				height = 0.5,
				border = "rounded",
				truncate_width = 70,
			})
		end,
	},
}
