return {
	"nvim-zh/colorful-winsep.nvim",
	enabled = false,
	config = function()
		require("colorful-winsep").setup({
			animate = {
				enabled = false,
			},
		})
	end,
	event = { "WinLeave" },
}
