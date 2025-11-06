return {
	{
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup()
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = (function()
					local result = {}
					for formatter, filetypes in pairs(Formatters) do
						for _, filetype in ipairs(filetypes) do
							result[filetype] = vim.list_extend(result[filetype] or {}, { formatter })
						end
					end
					return result
				end)(),
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},
			})
			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { desc = "Format buffer/selection" })
		end,
	},
}
