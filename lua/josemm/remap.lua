vim.g.mapleader = " "
vim.api.nvim_set_keymap(
	"n",
	"<leader>sv",
	":vsplit | b#<CR>",
	{ noremap = true, silent = true, desc = "Vertical split with previous buffer" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sh",
	":split | b#<CR>",
	{ noremap = true, silent = true, desc = "Horizontal split with previous buffer" }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>L",
	":Lazy <CR>",
	{ noremap = true, silent = true, desc = "Open Lazy plugin manager" }
)

vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Move to right window" })
vim.keymap.set("i", "<Esc>", "<C-c>", { noremap = true, silent = true, desc = "Exit insert mode" })

vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

vim.keymap.set("n", "<leader>q", function()
	vim.cmd("quitall")
end, { desc = "Quit vim" })
vim.keymap.set("n", "<leader>so", function()
	vim.cmd("so")
end, { desc = "Source current file" })
