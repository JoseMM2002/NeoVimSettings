return {
	{
		"folke/snacks.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "tpope/vim-fugitive" },
		},
		opts = {
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
		},
		config = function(_, opts)
			local snacks = require("snacks")
			snacks.setup(opts)
			local P = snacks.picker

			vim.keymap.set("n", "<leader><space>", function()
				P.smart()
			end, { desc = "Smart Open" })

			vim.keymap.set("n", "<leader>ff", function()
				P.files({ hidden = true, ignored = true })
			end, { desc = "Find files" })

			vim.keymap.set("n", "<leader>fb", function()
				P.buffers({ sort_lastused = true })
			end, { desc = "Find buffers" })

			vim.keymap.set("n", "<leader>fc", function()
				P.command_history({})
			end, { desc = "Commands" })

			vim.keymap.set("n", "<leader>fr", function()
				P.grep({})
			end, { desc = "Live grep" })

			vim.keymap.set("n", "<leader>fR", function()
				P.grep_buffers({})
			end, { desc = "Recent files" })

			vim.keymap.set("n", "<leader>fm", function()
				P.marks({})
			end, { desc = "Marks" })

			vim.keymap.set("n", "<leader>fh", function()
				P.help({})
			end, { desc = "Help" })

			vim.keymap.set("n", "<leader>fs", function()
				P.git_status({})
			end, { desc = "Git status" })

			vim.keymap.set("n", "<leader>fD", function()
				P.diagnostics({})
			end, { desc = "Diagnostics (workspace)" })

			vim.keymap.set("n", "<leader>fd", function()
				P.diagnostics_buffer({})
			end, { desc = "Diagnostics (buffer)" })

			vim.keymap.set("n", "<leader>fS", function()
				P.lsp_symbols({})
			end, { desc = "Symbols" })

			vim.keymap.set("n", "gr", function()
				P.lsp_references({})
			end, { desc = "LSP refs" })

			vim.keymap.set("n", "gd", function()
				P.lsp_definitions({})
			end, { desc = "LSP defs" })

			vim.keymap.set("n", "<leader>tc", function()
				P.colorschemes()
			end, { desc = "Colorschemes" })

			vim.keymap.set("n", "<leader>fn", function()
				if P.registers then
					P.registers()
				end
			end, { desc = "Registers" })

			vim.keymap.set("n", "<leader>fu", function()
				if P.undo then
					P.undo()
				end
			end, { desc = "Undo history" })
		end,
	},
}
