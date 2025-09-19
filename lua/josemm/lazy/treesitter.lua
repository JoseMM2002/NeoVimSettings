local ensure_installed = {
	"vimdoc",
	"javascript",
	"typescript",
	"c",
	"lua",
	"rust",
	"jsdoc",
	"bash",
	"python",
	"css",
	"html",
	"go",
	"cpp",
	"scss",
	"java",
	"prisma",
	"vue",
	"tsx",
	"zig",
	"yaml",
	"json",
	"nu",
	"dockerfile",
	"gitcommit",
	"git_rebase",
	"gitattributes",
	"gitignore",
	"gomod",
	"jsdoc",
	"json5",
	"jsonc",
	"jsx",
	"luadoc",
	"markdown",
	"markdown_inline",
	"nginx",
	"prisma",
	"scss",
	"sql",
	"ssh_config",
	"vim",
	"xml",
}

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})
		require("nvim-treesitter").install(ensure_installed)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = ensure_installed,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
