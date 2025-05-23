return {
	{
		"echasnovski/mini.ai",
		version = "*",
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = "*",
		opts = {
			custom_textobjects = nil,
			mappings = {
				around = "a",
				inside = "i",
				around_next = "an",
				inside_next = "in",
				around_last = "al",
				inside_last = "il",
				goto_left = "g[",
				goto_right = "g]",
			},
			n_lines = 500,
			search_method = "cover_or_next",
			silent = false,
		},
		config = function()
			require("mini.pairs").setup()
		end,
	},
}
