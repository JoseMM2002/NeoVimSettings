return {
	"ojroques/vim-oscyank",
	config = function()
		vim.keymap.set("n", "<leader>c", "<Plug>OSCYankOperator", { noremap = false })
		vim.keymap.set("n", "<leader>cc", "c_", { noremap = false })
		vim.keymap.set("v", "<leader>c", "<Plug>OSCYankVisual", { noremap = false })
	end,
}
