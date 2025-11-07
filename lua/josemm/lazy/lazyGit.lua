-- nvim v0.8.0
return {
	"kdheepak/lazygit.nvim",
	lazy = false,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function() end,
	keys = {
		{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
	},
}
