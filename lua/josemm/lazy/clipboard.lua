return {
	"ojroques/vim-oscyank",
	config = function()
		vim.keymap.set(
			"n",
			"<leader>y",
			"<Plug>OSCYankOperator",
			{ noremap = false, desc = "Copy with OSC yank operator" }
		)
		vim.keymap.set(
			"v",
			"<leader>y",
			"<Plug>OSCYankVisual",
			{ noremap = false, desc = "Copy visual selection with OSC yank" }
		)
	end,
}
