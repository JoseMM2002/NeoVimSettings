return {
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"neovim/nvim-lspconfig",
		init_options = {
			userLanguages = {
				eelixir = "html-eex",
				eruby = "erb",
				rust = "html",
			},
		},
	},
	{ "echasnovski/mini.icons" },
	{
		"xzbdmw/colorful-menu.nvim",
		config = function()
			-- You don't need to set these options.
			require("colorful-menu").setup({
				ls = {
					lua_ls = {
						-- Maybe you want to dim arguments a bit.
						arguments_hl = "@comment",
					},
					gopls = {
						-- By default, we render variable/function's type in the right most side,
						-- to make them not to crowd together with the original label.

						-- when true:
						-- foo             *Foo
						-- ast         "go/ast"

						-- when false:
						-- foo *Foo
						-- ast "go/ast"
						align_type_to_right = true,
						-- When true, label for field and variable will format like "foo: Foo"
						-- instead of go's original syntax "foo Foo". If align_type_to_right is
						-- true, this option has no effect.
						add_colon_before_type = false,
						-- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
						preserve_type_when_truncate = true,
					},
					-- for lsp_config or typescript-tools
					ts_ls = {
						-- false means do not include any extra info,
						-- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
						extra_info_hl = "@comment",
					},
					vtsls = {
						-- false means do not include any extra info,
						-- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
						extra_info_hl = "@comment",
					},
					["rust-analyzer"] = {
						-- Such as (as Iterator), (use std::io).
						extra_info_hl = "@comment",
						-- Similar to the same setting of gopls.
						align_type_to_right = true,
						-- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
						preserve_type_when_truncate = true,
					},
					clangd = {
						-- Such as "From <stdio.h>".
						extra_info_hl = "@comment",
						-- Similar to the same setting of gopls.
						align_type_to_right = true,
						-- the hl group of leading dot of "•std::filesystem::permissions(..)"
						import_dot_hl = "@comment",
						-- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
						preserve_type_when_truncate = true,
					},
					zls = {
						-- Similar to the same setting of gopls.
						align_type_to_right = true,
					},
					roslyn = {
						extra_info_hl = "@comment",
					},
					dartls = {
						extra_info_hl = "@comment",
					},
					-- The same applies to pyright/pylance
					basedpyright = {
						-- It is usually import path such as "os"
						extra_info_hl = "@comment",
					},
					-- If true, try to highlight "not supported" languages.
					fallback = true,
					-- this will be applied to label description for unsupport languages
					fallback_extra_info_hl = "@comment",
				},
				-- If the built-in logic fails to find a suitable highlight group for a label,
				-- this highlight is applied to the label.
				fallback_highlight = "@variable",
				-- If provided, the plugin truncates the final displayed text to
				-- this width (measured in display cells). Any highlights that extend
				-- beyond the truncation point are ignored. When set to a float
				-- between 0 and 1, it'll be treated as percentage of the width of
				-- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
				-- Default 60.
				max_width = 60,
			})
		end,
	},
	{
		"saghen/blink.cmp",
		version = "*",
		opts = {
			keymap = {
				preset = "default",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },

				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
			sources = {
				default = { "ecolog", "lsp", "path", "snippets", "buffer" },
				providers = {
					ecolog = { name = "ecolog", module = "ecolog.integrations.cmp.blink_cmp" },
					buffer = {
						opts = {
							-- or (recommended) filter to only "normal" buffers
							get_bufnrs = function()
								return vim.tbl_filter(function(bufnr)
									return vim.bo[bufnr].buftype == ""
								end, vim.api.nvim_list_bufs())
							end,
						},
					},
				},
			},
			completion = {
				menu = {
					border = "rounded",
					draw = {
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- Optionally, you may also use the highlights from mini.icons
								--
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
						columns = { { "kind_icon", "kind", gap = 2 }, { "label", "label_description", gap = 2 } },
						treesitter = { "lsp" },
						nil,
					},
				},
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				ghost_text = { enabled = true },
				keyword = {
					range = "full",
				},
				list = { selection = { preselect = false } },
			},
			signature = { window = { border = "rounded" }, enabled = true },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{ "L3MON4D3/LuaSnip" },
	{
		"philosofonusus/ecolog.nvim",
		opts = {
			integrations = {
				blink_cmp = true,
			},
			shelter = {
				configuration = {
					mask_char = "*",
				},
				modules = {
					cmp = true,
				},
			},
			path = vim.fn.getcwd(),
		},
	},
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
			vim.keymap.set("n", "<leader>rn", ":IncRename ")
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		config = function()
			local lsp_zero = require("lsp-zero")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			lsp_zero.extend_lspconfig()
			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			lsp_zero.set_sign_icons({
				error = "✘",
				warn = "▲",
				hint = "⚑",
				info = "»",
			})

			vim.diagnostic.config({
				virtual_text = false,
			})
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
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({ capabilities = capabilities })
					end,
					volar = function()
						require("lspconfig").volar.setup({ capabilities = capabilities })
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
	{
		"patrickpichler/hovercraft.nvim",

		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},

		-- this is the default config and can be skipped
		opts = function()
			return {
				providers = {
					providers = {
						{
							"LSP",
							require("hovercraft.provider.lsp.hover").new(),
						},
						{
							"Diagnostics",
							require("hovercraft.provider.diagnostics").new(),
						},
						{
							"Man",
							require("hovercraft.provider.man").new(),
						},
						{
							"Dictionary",
							require("hovercraft.provider.dictionary").new(),
						},
						{
							"Github Issue",
							require("hovercraft.provider.github.issue").new(),
						},
						{
							"Github Repo",
							require("hovercraft.provider.github.repo").new(),
						},
						{
							"Github User",
							require("hovercraft.provider.github.user").new(),
						},
						{
							"Github Blame",
							require("hovercraft.provider.git.blame").new(),
						},
					},
				},

				window = {
					border = "rounded",
				},

				keys = {
					{
						"<C-u>",
						function()
							require("hovercraft").scroll({ delta = -4 })
						end,
					},
					{
						"<C-d>",
						function()
							require("hovercraft").scroll({ delta = 4 })
						end,
					},
					{
						"<C-n>",
						function()
							require("hovercraft").hover_next()
						end,
					},
					{
						"<C-p>",
						function()
							require("hovercraft").hover_next({ step = -1 })
						end,
					},
				},
			}
		end,

		keys = {
			{
				"K",
				function()
					local hovercraft = require("hovercraft")

					if hovercraft.is_visible() then
						hovercraft.enter_popup()
					else
						hovercraft.hover()
					end
				end,
			},
		},
	},
}
