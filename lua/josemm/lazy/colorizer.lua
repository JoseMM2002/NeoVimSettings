return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			css = {
				css = true,
				css_fn = true,
			},
			scss = {
				css = true,
				css_fn = true,
			},
			sass = {
				css = true,
				css_fn = true,
			},
			toml = {
				css = true,
				css_fn = true,
			},
		})
	end,
}
