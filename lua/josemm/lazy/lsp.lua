return {
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		event = "LspAttach",
		opts = {
			--- The backend to use, currently only "vim", "delta" and "difftastic" are supported
			backend = "vim",
			-- The picker to use, "telescope", "snacks", "select" are supported
			-- If you want to use the `fzf-lua` picker, you can simply set it to `select`
			picker = "telescope",
			backend_opts = {
				delta = {
					-- Header from delta can be quite large.
					-- You can remove them by setting this to the number of lines to remove
					header_lines_to_remove = 4,

					-- The arguments to pass to delta
					-- If you have a custom configuration file, you can set the path to it like so:
					-- args = {
					--     "--config" .. os.getenv("HOME") .. "/.config/delta/config.yml",
					-- }
					args = {
						"--line-numbers",
					},
				},
				difftastic = {
					header_lines_to_remove = 1,
					args = {
						"--color=always",
						"--display=inline",
						"--syntax-highlight=on",
					},
				},
			},
			telescope_opts = {
				layout_strategy = "vertical",
				layout_config = {
					width = 0.7,
					height = 0.9,
					preview_cutoff = 1,
					preview_height = function(_, _, max_lines)
						local h = math.floor(max_lines * 0.5)
						return math.max(h, 10)
					end,
				},
			},
			signs = {
				quickfix = { "󰁨", { link = "DiagnosticInfo" } },
				others = { "?", { link = "DiagnosticWarning" } },
				refactor = { "", { link = "DiagnosticWarning" } },
				["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
				["refactor.extract"] = { "", { link = "DiagnosticError" } },
				["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
				["source.fixAll"] = { "", { link = "DiagnosticError" } },
				["source"] = { "", { link = "DiagnosticError" } },
				["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
				["codeAction"] = { "", { link = "DiagnosticError" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"rachartier/tiny-code-action.nvim",
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
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			vim.lsp.config("*", {
				capabilities,
			})
			require("lspconfig").nushell.setup({})
			require("mason").setup({ ui = { border = "rounded" } })
			vim.keymap.set("n", "<leader>M", "<cmd>Mason<cr>", { desc = "Mason" })

			vim.keymap.set("n", "<F4>", function()
				require("tiny-code-action").code_action()
			end, { desc = "Code actions" })
			vim.keymap.set("n", "<F2>", function()
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
					"clangd",
					"volar",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({ capabilities })
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
							capabilities,
						})
					end,
					jsonls = function()
						require("lspconfig").jsonls.setup({
							capabilities,
							filetypes = { "json", "jsonc" },
							settings = {
								json = {
									-- Schemas https://www.schemastore.org
									schemas = {
										{
											fileMatch = { "package.json" },
											url = "https://json.schemastore.org/package.json",
										},
										{
											fileMatch = { "tsconfig*.json" },
											url = "https://json.schemastore.org/tsconfig.json",
										},
										{
											fileMatch = {
												".prettierrc",
												".prettierrc.json",
												"prettier.config.json",
											},
											url = "https://json.schemastore.org/prettierrc.json",
										},
										{
											fileMatch = { ".eslintrc", ".eslintrc.json" },
											url = "https://json.schemastore.org/eslintrc.json",
										},
										{
											fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
											url = "https://json.schemastore.org/babelrc.json",
										},
										{
											fileMatch = { "lerna.json" },
											url = "https://json.schemastore.org/lerna.json",
										},
										{
											fileMatch = { "now.json", "vercel.json" },
											url = "https://json.schemastore.org/now.json",
										},
										{
											fileMatch = {
												".stylelintrc",
												".stylelintrc.json",
												"stylelint.config.json",
											},
											url = "http://json.schemastore.org/stylelintrc.json",
										},
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
}
