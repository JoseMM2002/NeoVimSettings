return {
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		event = "LspAttach",
		opts = {
			backend = "vim",
			picker = "telescope",
			backend_opts = {
				delta = {
					header_lines_to_remove = 4,
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
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"rachartier/tiny-code-action.nvim",
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
			local capabilities = {
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			}
			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
			require("lspconfig").nushell.setup({})
			require("mason").setup({ ui = { border = "rounded" } })
			vim.keymap.set("n", "<leader>M", "<cmd>Mason<cr>", { desc = "Mason" })

			vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, { desc = "Code actions" })
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
				automatic_enable = true,
				ensure_installed = {
					"vtsls",
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
					vtsls = function()
						local vue_typescript_plugin = require("mason-registry")
							.get_package("vue-language-server")
							:get_install_path() .. "/node_modules/@vue/language-server" .. "/node_modules/@vue/typescript-plugin"

						require("lspconfig").vtsls.setup({
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
					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							settings = {
								Lua = {
									telemetry = {
										enable = false,
									},
								},
							},
							on_init = function(client)
								local join = vim.fs.joinpath
								local path = client.workspace_folders[1].name

								-- Don't do anything if there is project local config
								if
									vim.uv.fs_stat(join(path, ".luarc.json"))
									or vim.uv.fs_stat(join(path, ".luarc.jsonc"))
								then
									return
								end

								local nvim_settings = {
									runtime = {
										-- Tell the language server which version of Lua you're using
										version = "LuaJIT",
									},
									diagnostics = {
										-- Get the language server to recognize the `vim` global
										globals = { "vim" },
									},
									workspace = {
										checkThirdParty = false,
										library = {
											-- Make the server aware of Neovim runtime files
											vim.env.VIMRUNTIME,
											vim.fn.stdpath("config"),
										},
									},
								}

								client.config.settings.Lua =
									vim.tbl_deep_extend("force", client.config.settings.Lua, nvim_settings)
							end,
						})
					end,
				},
			})
		end,
	},
}
