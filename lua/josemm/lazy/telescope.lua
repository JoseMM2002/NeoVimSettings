function printTable(t)
	for key, value in pairs(t) do
		if type(value) == "table" then
			print(key .. ":")
			printTable(value) -- Recursividad para subtablas
		else
			print(key, value)
		end
	end
end

function findGitIgnorePatterns()
	gitIgnorePath = vim.fn.getcwd() .. "/.gitignore"
	patterns = {}
	if vim.fn.filereadable(gitIgnorePath) == 1 then
		for line in io.lines(gitIgnorePath) do
			if not line:match("^#") and line ~= "" then
				table.insert(patterns, line)
			end
		end
	end
	return patterns
end

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
		local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
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

		vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")

		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})

		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word under Cursor" })
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)

		vim.keymap.set("n", "<leader>gc", live_grep_args_shortcuts.grep_word_under_cursor)
		vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

		vim.keymap.set("n", "<leader>pg", function()
			local patterns = findGitIgnorePatterns()
			builtin.git_files({
				git_icons = {
					changed = "M",
					staged = "S",
					untracked = "U",
				},
				git_cmd = {
					"git",
					"ls-files",
					"--exclude-standard",
					"--others",
					"--ignored",
					"--exclude-from",
					".gitignore",
				},
				prompt_title = "Git Files",
				attach_mappings = function(prompt_bufnr, map)
					local git_files = function()
						local selection = require("telescope.actions.state").get_selected_entry()
						require("telescope.actions").close(prompt_bufnr)
						vim.cmd("e " .. selection.value)
					end

					map("i", "<C-t>", git_files)
					map("n", "<C-t>", git_files)

					return true
				end,
			})
		end)

		vim.keymap.set("n", "<leader>pb", function()
			builtin.buffers({
				sort_lastused = true,
				sort_mru = true,
				attach_mappings = function(prompt_bufnr, map)
					local edit = function()
						local selection = require("telescope.actions.state").get_selected_entry()
						require("telescope.actions").close(prompt_bufnr)
						vim.cmd("buffer " .. selection.bufnr)
					end

					map("i", "<C-t>", edit)
					map("n", "<C-t>", edit)

					return true
				end,
			})
		end)

		vim.keymap.set("n", "<leader>pp", function()
			builtin.project({
				search_dirs = { vim.fn.getcwd() },
			})
		end)

		require("telescope").load_extension("neoclip")
		require("telescope").load_extension("undo")
		require("telescope").load_extension("live_grep_args")
	end,
}
