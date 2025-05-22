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
		return "󰃽 [" .. table.concat(sessionregisters, ",") .. "]"
	else
		return "󰃽"
	end
end

return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
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
