return {
	"ThePrimeagen/harpoon",
	requires = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		vim.keymap.set(
			"n",
			"<Leader>h",
			"<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<Leader>ha",
			"<cmd>lua require('harpoon.mark').add_file()<CR>",
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<Leader>he",
			"<cmd>lua require('harpoon.ui').nav_next()<CR>",
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"<Leader>hq",
			"<cmd>lua require('harpoon.ui').nav_prev()<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
