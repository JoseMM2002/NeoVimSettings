return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	opts = {},
	config = function(_)
		require("render-markdown").setup({
			completions = { lsp = { enabled = false } },
			file_types = { "Avante", "markdown", "copilot-chat", "codecompanion" },
			latex = { enabled = false },
		})
	end,
}
