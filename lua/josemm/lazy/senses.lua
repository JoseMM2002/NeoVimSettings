return {
	{
		"boltlessengineer/sense.nvim",

		config = function()
			local default_config = {
				presets = {
					virtualtext = {
						enabled = true,
						max_width = 0.4,
					},
					statuscolumn = {
						enabled = false,
					},
				},
				_log_level = vim.log.levels.WARN,
			}
			vim.g.sense_nvim = default_config
		end,
	},
}
