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
			"mason-org/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		init_options = {
			userLanguages = {
				eelixir = "html-eex",
				eruby = "erb",
				rust = "html",
			},
		},
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = (function()
					local ensure_installed = {}

					for formatter, _ in pairs(Formatters) do
						if FormattersNameExceptions[formatter] then
							formatter = FormattersNameExceptions[formatter]
						end
						if vim.tbl_contains(LocalFormatters, formatter) then
							goto continue
						end
						table.insert(ensure_installed, formatter)
						::continue::
					end

					for lsp, _ in pairs(MasonLsps) do
						table.insert(ensure_installed, lsp)
					end
					return ensure_installed
				end)(),
			})

			local diagnostic_signs = {
				[vim.diagnostic.severity.ERROR] = "✘",
				[vim.diagnostic.severity.WARN] = "▲",
				[vim.diagnostic.severity.HINT] = "⚑",
				[vim.diagnostic.severity.INFO] = "»",
			}

			local open_float = function()
				vim.diagnostic.open_float({
					border = "rounded",
					prefix = function(diagnostic)
						local sign = diagnostic_signs[diagnostic.severity] or "•"
						local signHighlightGroup = {
							[vim.diagnostic.severity.ERROR] = "DiagnosticError",
							[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
							[vim.diagnostic.severity.HINT] = "DiagnosticHint",
							[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
						}
						return string.format("%s ", sign), signHighlightGroup[diagnostic.severity] or "DiagnosticOk"
					end,
					header = "",
				})
			end

			local capabilities =
				vim.tbl_deep_extend("force", require("cmp_nvim_lsp").default_capabilities(), Capabilities)

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
			vim.keymap.set("n", "<Leader>e", function()
				open_float()
			end, { silent = true, desc = "Open diagnostics float" })
			vim.keymap.set({ "n", "x" }, "]d", function()
				vim.diagnostic.jump({ count = 1 })
				vim.schedule(function()
					open_float()
				end)
			end, { desc = "Jump to next diagnostic" })
			vim.keymap.set({ "n", "x" }, "[d", function()
				vim.diagnostic.jump({ count = -1 })
				vim.schedule(function()
					open_float()
				end)
			end, { desc = "Jump to prev diagnostic" })

			vim.diagnostic.config({
				signs = {
					text = diagnostic_signs,
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

			vim.lsp.config("angularls", {
				filetypes = { "typescript", "html", "htmlangular" },
			})

			local enabled_lsps = (function()
				local result = {}
				for _, lsp in pairs(MasonLsps) do
					if lsp ~= nil then
						table.insert(result, lsp)
					end
				end
				return result
			end)()

			vim.lsp.enable(vim.tbl_extend("force", {}, enabled_lsps, LocalLsps))
		end,
	},
}
