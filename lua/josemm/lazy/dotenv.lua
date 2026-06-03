return {
	"JoseMM2002/dotenv.nvim",
	priority = 1000,
	config = function()
		require("dotenv").setup({
			env_paths = {
				vim.fn.expand("~/.config/nvim/.env"),
				(ProjectRoot or vim.uv.cwd()) .. "/.env",
			},
		})
	end,
}
