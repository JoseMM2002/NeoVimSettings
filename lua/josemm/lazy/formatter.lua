function setFormatters()
	local formatters = {
		prettier = {
			"javascript",
			"typescript",
			"vue",
			"javascriptreact",
			"typescriptreact",
			"html",
			"css",
			"json",
			"scss",
			"sass",
		},
		stylua = {
			"lua",
		},
	}

	local formatedConfig = {
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	}

	for formatter, filetypes in pairs(formatters) do
		for _, filetype in ipairs(filetypes) do
			if not formatedConfig[filetype] then
				formatedConfig[filetype] = {}
			end
			table.insert(formatedConfig[filetype], require("formatter.filetypes." .. filetype)[formatter])
		end
	end
	return formatedConfig
end

return {
	"mhartington/formatter.nvim",
	config = function()
		require("formatter").setup({
			filetype = setFormatters(),
		})

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			command = "FormatWriteLock",
		})
	end,
}
