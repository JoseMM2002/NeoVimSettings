return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy", -- Or `LspAttach`
	priority = 1000, -- needs to be loaded in first
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "powerline",
			options = {
				break_line = {
					enabled = true,
				},
				show_source = {
					enabled = true,
				},
			},
		})
	end,
}
