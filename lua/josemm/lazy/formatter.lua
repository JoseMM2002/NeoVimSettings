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
		"jsonc",
		"scss",
		"markdown",
		"sass",
		"yaml",
	},
	stylua = {
		"lua",
	},
	taplo = {
		"toml",
	},
	shfmt = {
		"sh",
	},
	sql_formatter = {
		"sql",
	},
}

return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = (function()
				local result = {}
				for formatter, filetypes in pairs(formatters) do
					for _, filetype in ipairs(filetypes) do
						result[filetype] = { formatter }
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
		end)
	end,
}
