vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<leader>vv", ":vsplit | b#<CR>", { noremap = true, silent = true })
