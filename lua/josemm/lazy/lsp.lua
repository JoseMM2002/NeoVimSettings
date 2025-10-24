local lsp_list = {
	"vtsls",
	"rust_analyzer",
	"gopls",
	"basedpyright",
	"ruff",
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
	"eslint",
	"postgres_lsp",
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
			vim.keymap.set("n", "<leader>ry", function()
				vim.lsp.buf.rename(vim.fn.getreg('"'))
			end, { desc = "Rename symbol with registry" })

			vim.keymap.set("n", "K", function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover({ border = "rounded" })
				end
			end, { desc = "Hover symbol details" })

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

			local base_on_attach = vim.lsp.config.eslint.on_attach
			vim.lsp.config("eslint", {
				on_attach = function(client, bufnr)
					if not base_on_attach then
						return
					end

					base_on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "LspEslintFixAll",
					})
				end,
			})

			vim.lsp.enable({ "nushell" })
		end,
	},
}
