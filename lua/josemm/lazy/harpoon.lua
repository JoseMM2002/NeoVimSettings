return {
	"JoseMM2002/harpoon",
	enabled = true,
	branch = "harpoon2-window-position",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Add file to harpoon list" })
		vim.keymap.set("n", "<leader>hh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list(), {
				window_position = {
					row = function()
						return 0
					end,
					col = function(width)
						return vim.o.columns - width
					end,
				},
			})
		end, { desc = "Toggle harpoon quick menu" })

		vim.keymap.set("n", "<leader>hq", function()
			harpoon:list():prev()
		end, { desc = "Navigate to previous harpoon file" })
		vim.keymap.set("n", "<leader>he", function()
			harpoon:list():next()
		end, { desc = "Navigate to next harpoon file" })

		local harpoon_extensions = require("harpoon.extensions")
		harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
	end,
}
