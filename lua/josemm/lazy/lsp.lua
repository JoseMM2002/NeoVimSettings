return {
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
			vim.keymap.set("n", "<leader>rn", ":IncRename ")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		init_options = {
			userLanguages = {
				eelixir = "html-eex",
				eruby = "erb",
				rust = "html",
			},
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			require("lspconfig").nushell.setup({})
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"rust_analyzer",
					"volar",
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
					"sqlls",
					"clangd",
					"volar",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({ capabilities = capabilities })
					end,
					ts_ls = function()
						local vue_typescript_plugin = require("mason-registry")
							.get_package("vue-language-server")
							:get_install_path() .. "/node_modules/@vue/language-server" .. "/node_modules/@vue/typescript-plugin"

						require("lspconfig").ts_ls.setup({
							init_options = {
								plugins = {
									{
										name = "@vue/typescript-plugin",
										location = vue_typescript_plugin,
										languages = { "javascript", "typescript", "vue" },
									},
								},
							},
							filetypes = {
								"javascript",
								"javascriptreact",
								"javascript.jsx",
								"typescript",
								"typescriptreact",
								"typescript.tsx",
								"vue",
							},
							capabilities = capabilities,
						})
					end,
				},
			})

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").filetype_extend("vue", { "vue" })
		end,
	},
}
