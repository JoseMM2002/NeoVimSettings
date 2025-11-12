local get_registers_status = function()
	local reg = vim.fn.reg_recording()
	local sessionregisters = vim.g.sessionregisters or {}
	if reg ~= "" then
		local regExists = false
		for _, val in ipairs(sessionregisters) do
			if val == reg then
				regExists = true
				break
			end
		end
		if not regExists then
			vim.g.sessionregisters = vim.list_extend(sessionregisters, { reg })
		end
		return "  " .. "[" .. reg .. "]"
	end
	if #sessionregisters > 0 then
		return "󰴘 [" .. table.concat(sessionregisters, ",") .. "]"
	else
		return " "
	end
end

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			{
				"SmiteshP/nvim-navic",
				opts = {
					highlight = true,
					lsp = { auto_attach = true },
					icons = {
						File = " ",
						Module = " ",
						Namespace = " ",
						Package = " ",
						Class = " ",
						Method = " ",
						Property = " ",
						Field = " ",
						Constructor = " ",
						Enum = " ",
						Interface = " ",
						Function = " ",
						Variable = " ",
						Constant = " ",
						String = " ",
						Number = " ",
						Boolean = " ",
						Array = " ",
						Object = " ",
						Key = " ",
						Null = " ",
						EnumMember = " ",
						Struct = " ",
						Event = " ",
						Operator = " ",
						TypeParameter = " ",
					},
				},
				config = function(_, opts)
					require("nvim-navic").setup(opts)
				end,
			},
		},
		config = function()
			local navic = require("nvim-navic")
			require("lualine").setup({
				options = {
					component_separators = "",
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
					lualine_b = {
						"filename",
						"branch",
						{
							"macro",
							fmt = get_registers_status,
						},
					},
					lualine_c = {
						"diff",
						"diagnostics",
						{
							function()
								return navic.get_location()
							end,
							cond = function()
								return navic.is_available()
							end,
						},
					},
					lualine_x = {},
					lualine_y = { "filetype" },
					lualine_z = {
						{ "location", separator = { left = "", right = "" } },
					},
				},

				inactive_sections = {
					lualine_a = { "filename" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { "location" },
				},
				tabline = {},
				extensions = {},
			})
		end,
	},
}
