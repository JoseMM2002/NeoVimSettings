return {
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup()
		end,
	},
	"ldelossa/gh.nvim",
	dependencies = {
		{
			"ldelossa/litee.nvim",
			config = function()
				require("litee.lib").setup()
			end,
		},
	},
	config = function()
		require("litee.gh").setup()
	end,
}
