return {
	"rcarriga/nvim-notify",
	priority = 10000,
	config = function()
		local notify = require("notify")
		vim.notify = notify
		vim.notify("Notify loaded", "info", {
			title = "Notify",
			timeout = 1000,
		})
	end,
}
