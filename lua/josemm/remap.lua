vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<leader>sv", ":vsplit | b#<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sh", ":split | b#<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>L", ":Lazy <CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
