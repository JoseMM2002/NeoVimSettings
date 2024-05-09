vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Definir un nuevo comando para abrir una terminal en el directorio actual
function _G.open_terminal()
    -- Salir de Neovim y abrir una terminal. Cambiar 'gnome-terminal' por tu terminal.
    vim.cmd('silent !alacritty --working-directory=' .. vim.fn.getcwd() .. ' &')
end

-- Asignar el comando al atajo 'Leader' + 't'
vim.api.nvim_set_keymap('n', '<Leader>t', ':lua open_terminal()<CR>', { noremap = true, silent = true })
