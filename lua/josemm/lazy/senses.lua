return {
	{
		"boltlessengineer/sense.nvim",

		config = function()
			---sense.nvim default configuration
			---@class sense.Config
			local default_config = {
				---Preset components config
				---@class sense.Config.Presets
				presets = {
					---Config for diagnostic virtualtest component
					---@class sense.Config.Presets.VirtualText
					virtualtext = {
						---@type boolean enable diagnostic virtualtext component
						enabled = true,
						---@type number max width of virtualtext component
						max_width = 0.7,
					},
					---Config for diagnostic statuscolumn component
					---@class sense.Config.Presets.StatusColumn
					statuscolumn = {
						---@type boolean enable diagnostic statuscolumn component
						enabled = true,
					},
				},
				_log_level = vim.log.levels.WARN,
			}
			vim.g.sense_nvim = default_config
		end,
	},
}
