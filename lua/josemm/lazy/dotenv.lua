function testEnv()
	local env_vars = require("dotenv").get_env_vars()
	vim.notify(vim.inspect(env_vars))
end
return {
	"JoseMM2002/dotenv.nvim",
	priority = 1000,
	config = function()
		require("dotenv").setup({
			env_path = vim.fn.expand("~/.config/nvim/.env"),
		})
	end,
}
