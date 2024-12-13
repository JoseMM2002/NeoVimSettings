return {
	"rcarriga/nvim-notify",
	priority = 10000,
	config = function()
		local notify = require("notify")
		vim.notify = notify
	end,
}
