vim.g.mapleader = " "

-- Definir un nuevo comando para abrir una terminal en el directorio actual
function _G.open_terminal()
	-- Salir de Neovim y abrir una terminal. Cambiar 'gnome-terminal' por tu terminal.
	vim.cmd("silent !kitty --working-directory=" .. vim.fn.getcwd() .. " &")
end

-- Asignar el comando al atajo 'Leader' + 't'
vim.api.nvim_set_keymap("n", "<Leader>t", ":lua open_terminal()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>vv", ":vsplit | b#<CR>", { noremap = true, silent = true })
