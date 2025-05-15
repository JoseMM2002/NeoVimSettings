return {
	{
		"patrickpichler/hovercraft.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", "kevinhwang91/nvim-ufo" },
		},
		opts = function()
			return {
				providers = {
					providers = {
						{
							"LSP",
							require("hovercraft.provider.lsp.hover").new(),
						},
						{
							"Diagnostics",
							require("hovercraft.provider.diagnostics").new(),
						},
						{
							"Man",
							require("hovercraft.provider.man").new(),
						},
						{
							"Dictionary",
							require("hovercraft.provider.dictionary").new(),
						},
						{
							"Github Issue",
							require("hovercraft.provider.github.issue").new(),
						},
						{
							"Github Repo",
							require("hovercraft.provider.github.repo").new(),
						},
						{
							"Github User",
							require("hovercraft.provider.github.user").new(),
						},
						{
							"Github Blame",
							require("hovercraft.provider.git.blame").new(),
						},
					},
				},
				window = {
					border = "rounded",
					render_markdown_compat_mode = true,
				},
				keys = {
					{
						"<C-u>",
						function()
							require("hovercraft").scroll({ delta = -4 })
						end,
					},
					{
						"<C-d>",
						function()
							require("hovercraft").scroll({ delta = 4 })
						end,
					},
					{
						"<C-n>",
						function()
							require("hovercraft").hover_next()
						end,
					},
					{
						"<C-p>",
						function()
							require("hovercraft").hover_next({ step = -1 })
						end,
					},
				},
			}
		end,

		keys = {
			{
				"K",
				function()
					local winid = require("ufo").peekFoldedLinesUnderCursor()
					if not winid then
						local hovercraft = require("hovercraft")
						if hovercraft.is_visible() then
							hovercraft.enter_popup()
						else
							hovercraft.hover()
						end
					end
				end,
			},
		},
	},
}
