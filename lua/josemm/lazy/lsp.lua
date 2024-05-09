return {
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "onsails/lspkind.nvim" },
	{ "rafamadriz/friendly-snippets" },
	{ "saadparwaiz1/cmp_luasnip" },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			lsp_zero.format_on_save({
				format_opts = {
					async = false,
					timeout_ms = 10000,
				},
				servers = {
					["rust_analyzer"] = { "rust" },
					["gopls"] = { "go" },
					["bashls"] = { "bash" },
					["zls"] = { "zig" },
				},
			})

			lsp_zero.set_sign_icons({
				error = "✘",
				warn = "▲",
				hint = "⚑",
				info = "»",
			})

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"tsserver",
					"rust_analyzer",
					"volar",
					"gopls",
					"pyright",
					"html",
					"tailwindcss",
					"bashls",
					"eslint",
					"lua_ls",
					"jsonls",
					"cssls",
					"zls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					volar = function()
						require("lspconfig").volar.setup({})
					end,
					tsserver = function()
						local vue_typescript_plugin = require("mason-registry")
							.get_package("vue-language-server")
							:get_install_path() .. "/node_modules/@vue/language-server" .. "/node_modules/@vue/typescript-plugin"

						require("lspconfig").tsserver.setup({
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
						})
					end,
				},
			})

			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
			require("copilot_cmp").setup()
			local cmp = require("cmp")
			local cmp_action = require("lsp-zero").cmp_action()
			local cmp_format = require("lsp-zero").cmp_format({ details = true })
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").filetype_extend("vue", { "vue" })

			cmp.setup({
				sources = {
					{ name = "luasnip" },
					-- { name = "copilot" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "nvim_lua" },
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
					["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
				}),
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = require("lspkind").cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = 80, -- prevent the popup from showing more than provided characters
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
					}),
				},
			})
		end,
	},
}
