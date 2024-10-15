return {
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "tokyonight-night",
				transparent = true,
			})
			vim.cmd("colorscheme tokyonight-night")
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
}
