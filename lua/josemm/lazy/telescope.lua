return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"AckslD/nvim-neoclip.lua",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{ "nvim-tree/nvim-web-devicons", opts = {} },
	},
	config = function()
		local builtin = require("telescope.builtin")
		local lga_actions = require("telescope-live-grep-args.actions")

		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<Esc>"] = "close",
					},
				},
			},
			extensions = {
				undo = {
					side_by_side = true,
					layout_strategy = "vertical",
					layout_config = {
						preview_height = 0.8,
					},
					mappings = {
						i = {
							["<cr>"] = require("telescope-undo.actions").yank_additions,
							["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
							["<C-cr>"] = require("telescope-undo.actions").restore,
							["<C-y>"] = require("telescope-undo.actions").yank_deletions,
							["<C-r>"] = require("telescope-undo.actions").restore,
						},
						n = {
							["y"] = require("telescope-undo.actions").yank_additions,
							["Y"] = require("telescope-undo.actions").yank_deletions,
							["u"] = require("telescope-undo.actions").restore,
						},
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
				fzy_native = {
					override_generic_sorter = true,
					override_file_sorter = true,
				},
			},
		})

		require("neoclip").setup({})

		vim.keymap.set("n", "<leader>fu", function()
			require("telescope").extensions.undo.undo()
		end)

		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({ hidden = true })
		end)

		vim.keymap.set("n", "<leader>fb", function()
			require("telescope.builtin").buffers({ sort_lastused = true })
		end)

		vim.keymap.set("n", "<leader>fr", function()
			require("telescope.builtin").live_grep({})
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

		vim.keymap.set("n", "<leader>fgd", function()
			require("telescope.builtin").diagnostics()
		end)

		vim.keymap.set("n", "<leader>fd", function()
			require("telescope.builtin").diagnostics({
				bufnr = 0,
			})
		end)

		vim.keymap.set("n", "<leader>fls", function()
			require("telescope.builtin").lsp_document_symbols()
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "gr", function()
			require("telescope.builtin").lsp_references()
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "gd", function()
			require("telescope.builtin").lsp_definitions()
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "<leader>tc", function()
			require("telescope.builtin").colorscheme({ enable_preview = true })
		end)

		require("telescope").load_extension("neoclip")
		require("telescope").load_extension("undo")
		require("telescope").load_extension("live_grep_args")
		require("telescope").load_extension("fzf")
	end,
}
