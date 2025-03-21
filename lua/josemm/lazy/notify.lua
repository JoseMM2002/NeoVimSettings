return {
	"rcarriga/nvim-notify",
	priority = 10000,
	config = function()
		require("notify").setup({
			timeout = 100,
			background_colour = "#000000",
			render = "compact",
		})
		local notify = require("notify")
		vim.notify = notify
	end,
}
