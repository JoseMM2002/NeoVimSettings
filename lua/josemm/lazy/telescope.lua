return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.5",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"AckslD/nvim-neoclip.lua",
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

		require("neoclip").setup({})

		vim.keymap.set("n", "<leader>fu", function()
			require("telescope").extensions.undo.list()
		end)

		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({
				hidden = true,
			})
		end)

		vim.keymap.set("n", "<leader>fb", function()
			require("telescope.builtin").buffers({})
		end)

		vim.keymap.set("n", "<leader>fr", function()
			require("telescope.builtin").live_grep({
				search = vim.fn.input("Search for: "),
			})
		end)

		vim.keymap.set("n", "<leader>fh", function()
			builtin.help_tags({})
		end)

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

		vim.keymap.set("n", "<leader>fn", function()
			require("telescope").extensions.neoclip.default()
		end)

		vim.keymap.set("n", "fr", function()
			require("telescope.builtin").lsp_references()
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "fd", function()
			require("telescope.builtin").lsp_definitions()
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "fc", function()
			require("telescope.builtin").get_cursor()
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "fs", function()
			require("telescope.builtin").lsp_document_symbols()
		end, { noremap = true, silent = true })

		require("telescope").load_extension("neoclip")
		require("telescope").load_extension("undo")
		require("telescope").load_extension("live_grep_args")
	end,
}
