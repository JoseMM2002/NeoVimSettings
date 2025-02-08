return {
	"ojroques/vim-oscyank",
	config = function()
		vim.keymap.set("n", "<leader>cy", "<Plug>OSCYankOperator", { noremap = false })
		vim.keymap.set("n", "<leader>cc", "c_", { noremap = false })
		vim.keymap.set("v", "<leader>cy", "<Plug>OSCYankVisual", { noremap = false })
	end,
}
