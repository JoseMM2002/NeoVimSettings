return {
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "tokyonight-night",
				transparent = true,
			})
			-- vim.cmd("colorscheme tokyonight-night")
		end,
	},
	{
		"catppuccin/nvim",
		config = function()
			require("catppuccin").setup({
				flavour = "latte",
				transparent_background = true,
			})
			--[[ vim.cmd("colorscheme catppuccin") ]]
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				transparent = true,
			})
			-- vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({
				transparent_mode = true,
			})
		end,
	},
	{ "rose-pine/neovim", name = "rose-pine" },
	{
		"EdenEast/nightfox.nvim",

		config = function()
			-- vim.cmd("colorscheme carbonfox")
		end,
	},
	{
		"olivercederborg/poimandres.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("poimandres").setup({})
		end,
		init = function()
			-- vim.cmd("colorscheme poimandres")
		end,
	},
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = vim.fn.getcompletion("", "color"),
				livePreview = true,
			})
			vim.api.nvim_set_keymap("n", "<leader>tc", ":Themery<CR>", { noremap = true, silent = true })
		end,
	},
	{
		"JoseMM2002/walltheme.nvim",
		config = function()
			-- require("walltheme").setup()
		end,
	},
	{
		"xiyaowong/transparent.nvim",
		config = function() end,
	},
	{
		"AlexvZyl/nordic.nvim",
	},
}
