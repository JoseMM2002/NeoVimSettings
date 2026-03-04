return {
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "tokyonight-night",
			})
			-- vim.cmd("colorscheme tokyonight-night")
		end,
	},
	{
		"catppuccin/nvim",
		config = function()
			require("catppuccin").setup({
				flavour = "latte",
			})
			--[[ vim.cmd("colorscheme catppuccin") ]]
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({})
			-- vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({})
		end,
	},
	{ "rose-pine/neovim", name = "rose-pine" },
	{
		"EdenEast/nightfox.nvim",
		config = function()
			-- vim.cmd("colorscheme terafox")
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
		"RedsXDD/neopywal.nvim",
		config = function()
			require("neopywal").setup({
				use_palette = {
					light = "wallust",
					dark = "wallust",
				},
				transparent_background = true,
				colorscheme_file = vim.fn.expand("~/.cache/wallust/colors_neopywal.vim"),
			})
			vim.cmd.colorscheme("neopywal")
		end,
	},
	{
		"xiyaowong/transparent.nvim",
		config = function() end,
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme nordic")
		end,
	},
	{
		"RomanAverin/charleston.nvim",
		opts = {
			darken_background = true,
		},
	},
	{
		"webhooked/kanso.nvim",
		config = function()
			-- vim.cmd("colorscheme kanso")
		end,
	},
	{
		"connormxfadden/petrolnoir.nvim",
		priority = 1000, -- load before other UI plugins
		config = function()
			-- vim.cmd("colorscheme petrolnoir")
		end,
	},
}
