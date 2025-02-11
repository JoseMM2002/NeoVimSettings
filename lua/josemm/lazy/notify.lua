return {
	"rcarriga/nvim-notify",
	priority = 10000,
	config = function()
		require("notify").setup({
			timeout = 100,
			render = "compact",
		})
		local notify = require("notify")
		vim.notify = notify
	end,
}
