return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.5",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
	},
	config = function()
		local builtin = require("telescope.builtin")
		local lga_actions = require("telescope-live-grep-args.actions")

		require("telescope").setup({
			extensions = {
				undo = {
					side_by_side = true,
					layout_strategy = "vertical",
					layout_config = {
						preview_height = 0.8,
					},
				},

				live_grep_args = {
					auto_quoting = true, -- enable/disable auto-quoting
					-- define mappings, e.g.
					mappings = { -- extend mappings
						i = {
							["<C-k>"] = lga_actions.quote_prompt(),
							["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
						},
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>fu", ":lua require('telescope').extensions.undo.list()<CR>")
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({
				hidden = true,
				no_ignore = true,
				no_ignore_parent = true,
			})
		end)
		vim.keymap.set("n", "<leader>fb", ":lua require('telescope.builtin').buffers()<CR>")
		vim.keymap.set("n", "<leader>fr", ":lua require('telescope.builtin').live_grep()<CR>")
		vim.keymap.set("n", "<leader>fh", ":lua require('telescope.builtin').help_tags()<CR>")
		vim.keymap.set("n", "<leader>fs", function()
			require("telescope.builtin").git_status({
				git_icons = {
					changed = "",
					added = "",
					renamed = "",
					unmerged = "",
					deleted = "",
					untracked = "",
					copied = "󰬸",
				},
			})
		end)

		require("telescope").load_extension("neoclip")
		require("telescope").load_extension("undo")
		require("telescope").load_extension("live_grep_args")
	end,
}
