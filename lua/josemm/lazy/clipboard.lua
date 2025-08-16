return {
	"ojroques/vim-oscyank",
	config = function()
		vim.keymap.set("n", "<leader>c", "<Plug>OSCYankOperator", { noremap = false, desc = "Copy with OSC yank operator" })
		vim.keymap.set("n", "<leader>cc", "c_", { noremap = false, desc = "Copy current line with OSC yank" })
		vim.keymap.set("v", "<leader>c", "<Plug>OSCYankVisual", { noremap = false, desc = "Copy visual selection with OSC yank" })
	end,
}
