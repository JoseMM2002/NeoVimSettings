return {
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				panel = { enabled = false },
				suggestion = {
					enabled = false,
					auto_trigger = false,
					trigger_on_accept = false,
				},
				copilot_model = "gpt-4.1",
				markdown = true,
				help = true,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuOpen",
				callback = function()
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
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		opts = {
			provider = "copilot",
			copilot = {
				model = "gemini-2.5-pro", -- o1-preview | o1-mini | claude-3.5-sonnet
			},
			windows = {
				---@type "right" | "left" | "top" | "bottom"
				position = "right", -- the position of the sidebar
				wrap = true, -- similar to vim.o.wrap
				width = 30, -- default % based on available width
				sidebar_header = {
					enabled = true, -- true, false to enable/disable the header
					align = "center", -- left, center, right for title
					rounded = false,
				},
				input = {
					prefix = "> ",
					height = 8, -- Height of the input window in vertical layout
				},
				edit = {
					start_insert = true, -- Start insert mode when opening the edit window
					border = "rounded",
				},
				ask = {
					floating = false, -- Open the 'AvanteAsk' prompt in a floating window
					start_insert = true, -- Start insert mode when opening the ask window
					---@type "ours" | "theirs"
					focus_on_apply = "ours", -- which diff to focus after applying
				},
			},
			file_selector = {
				provider = "telescope",
			},
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
			},
		},
	},
}
