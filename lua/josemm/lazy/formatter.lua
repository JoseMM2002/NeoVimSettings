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

	local formatedConfig = {}

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
	-- "mhartington/formatter.nvim",
	-- config = function()
	-- 	require("formatter").setup({
	-- 		filetype = setFormatters(),
	-- 	})

	-- 	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	-- 		command = "FormatWriteLock",
	-- 	})
	-- end,
	--
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				vue = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				scss = { "prettier" },
				markdown = { "prettier" },
				sass = { "prettier" },

				lua = { "stylua" },
				toml = { "taplo" },
				sh = { "shfmt" },
				sql = { "sql_formatter" },
			},
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
