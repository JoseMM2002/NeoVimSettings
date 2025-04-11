return {
	{

		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- | top | left | right | horizontal | vertical
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = false,
					hide_during_completion = true,
					debounce = 75,
					trigger_on_accept = true,
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_model = "claude-3.7-sonnet", -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
			})
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			-- add any opts here
			-- for example
			provider = "copilot",
			copilot = {
				model = "claude-3.7-sonnet", -- o1-preview | o1-mini | claude-3.5-sonnet
			},
			windows = {
				---@type "right" | "left" | "top" | "bottom"
				position = "left", -- the position of the sidebar
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
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
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
