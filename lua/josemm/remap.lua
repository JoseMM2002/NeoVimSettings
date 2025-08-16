vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<leader>sv", ":vsplit | b#<CR>", { noremap = true, silent = true, desc = "Vertical split with previous buffer" })
vim.api.nvim_set_keymap("n", "<leader>sh", ":split | b#<CR>", { noremap = true, silent = true, desc = "Horizontal split with previous buffer" })
vim.api.nvim_set_keymap("n", "<leader>L", ":Lazy <CR>", { noremap = true, silent = true, desc = "Open Lazy plugin manager" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Move to right window" })
vim.keymap.set("i", "<Esc>", "<C-c>", { noremap = true, silent = true, desc = "Exit insert mode" })
