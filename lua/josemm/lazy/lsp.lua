local lsp_list = {
	"vtsls",
	"rust_analyzer",
	"gopls",
	"pyright",
	"html",
	"tailwindcss",
	"bashls",
	"lua_ls",
	"jsonls",
	"cssls",
	"zls",
	"somesass_ls",
	"jdtls",
	"gradle_ls",
	"prismals",
	"clangd",
	"vue_ls",
}

local capabilities = {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
}

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					ui = { border = "rounded" },
				},
			},
			{
				"mason-org/mason-lspconfig.nvim",
				opts = {
					automatic_enable = true,
					ensure_installed = lsp_list,
				},
			},
			"saghen/blink.cmp",
			"esmuellert/nvim-eslint",
		},
		init_options = {
			userLanguages = {
				eelixir = "html-eex",
				eruby = "erb",
				rust = "html",
			},
		},
		config = function()
			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

			vim.keymap.set("n", "<leader>M", "<cmd>Mason<cr>", { desc = "Open Mason LSP manager" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
			vim.keymap.set("n", "<leader>rn", function()
				vim.lsp.buf.rename()
			end, { desc = "Rename symbol" })

			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "✘",
						[vim.diagnostic.severity.WARN] = "▲",
						[vim.diagnostic.severity.HINT] = "⚑",
						[vim.diagnostic.severity.INFO] = "»",
					},
				},
			})

			vim.lsp.config("*", { capabilities })
			local vue_typescript_plugin = vim.fn.stdpath("data")
				.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

			local vue_plugin = {
				name = "@vue/typescript-plugin",
				location = vue_typescript_plugin,
				languages = { "vue" },
				configNamespace = "typescript",
			}

			vim.lsp.config("vtsls", {
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								vue_plugin,
							},
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			})

			vim.lsp.enable({ "nushell" })
			require("nvim-eslint").setup({})
		end,
	},
}
