return {
	"JoseMM2002/harpoon",
	enabled = false,
	branch = "harpoon2-window-position",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end)
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
		end)

		vim.keymap.set("n", "<leader>hq", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<leader>he", function()
			harpoon:list():next()
		end)

		local harpoon_extensions = require("harpoon.extensions")
		harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
	end,
}
