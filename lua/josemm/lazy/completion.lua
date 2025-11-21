local kind_icons = {
	Avante = "󰭹",
	Copilot = "",
}

return {
	{
		"philosofonusus/ecolog.nvim",
		opts = {
			integrations = {
				blink_cmp = true,
				snacks = {
					shelter = {
						mask_on_copy = false, -- Whether to mask values when copying
					},
					keys = {
						copy_value = "<C-y>", -- Copy variable value to clipboard
						copy_name = "<C-u>", -- Copy variable name to clipboard
						append_value = "<C-a>", -- Append value at cursor position
						append_name = "<CR>", -- Append name at cursor position
						edit_var = "<C-e>", -- Edit environment variable
					},
					layout = { -- Any Snacks layout configuration
						preset = "dropdown",
						preview = false,
					},
				},
			},

			shelter = {
				configuration = {
					partial_mode = {
						show_start = 1,
						show_end = 1,
						min_mask = 3,
					},
					mask_char = "*",
					mask_length = nil,
					skip_comments = false,
				},
				modules = {
					cmp = true,
					files = false,
					peek = true,
					snacks_previewer = true,
					snacks = true,
				},
			},

			path = vim.fn.getcwd(),
			provider_patterns = { extract = true, cmp = false },
		},
		keys = {
			{ "<leader>ge", "<cmd>EcologGoto<cr>", desc = "Go to env file" },
		},
	},

	{
		"xzbdmw/colorful-menu.nvim",
		config = function()
			require("colorful-menu").setup({
				ls = {
					lua_ls = {
						arguments_hl = "@comment",
					},
					gopls = {
						align_type_to_right = true,
						add_colon_before_type = false,
						preserve_type_when_truncate = true,
					},
					ts_ls = {
						extra_info_hl = "@comment",
					},
					vtsls = {
						extra_info_hl = "@comment",
					},
					["rust-analyzer"] = {
						extra_info_hl = "@comment",
						align_type_to_right = true,
						preserve_type_when_truncate = true,
					},
					clangd = {
						extra_info_hl = "@comment",
						align_type_to_right = true,
						import_dot_hl = "@comment",
						preserve_type_when_truncate = true,
					},
					zls = {
						align_type_to_right = true,
					},
					roslyn = {
						extra_info_hl = "@comment",
					},
					dartls = {
						extra_info_hl = "@comment",
					},
					basedpyright = {
						extra_info_hl = "@comment",
					},
					fallback = true,
					fallback_extra_info_hl = "@comment",
				},
				fallback_highlight = "@variable",
				max_width = 60,
			})
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	{

		"onsails/lspkind.nvim",
		config = function()
			local lspkind = require("lspkind")
			lspkind.init({
				symbol_map = kind_icons,
			})
		end,
	},

	{
		"saghen/blink.cmp",
		version = "1.7.0",
		dependencies = {
			"onsails/lspkind.nvim",
			"nvim-tree/nvim-web-devicons",
			"philosofonusus/ecolog.nvim",
			"giuxtaposition/blink-cmp-copilot",
		},
		build = "cargo build --release",
		opts = {
			snippets = { preset = "luasnip" },
			sources = {
				default = {
					"ecolog",
					"lsp",
					"snippets",
					"path",
					"copilot",
				},
				providers = {
					ecolog = {
						min_keyword_length = 1,
						name = "ecolog",
						module = "ecolog.integrations.cmp.blink_cmp",
					},
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = -1000,
						async = true,
					},
				},
			},

			fuzzy = {
				sorts = {
					"score", -- Primary sort: by fuzzy matching score
					"sort_text", -- Secondary sort: by sortText field if scores are equal
					"label", -- Tertiary sort: by label if still tied
				},
				implementation = "prefer_rust_with_warning",
			},

			completion = {
				ghost_text = { enabled = true },
				keyword = { range = "full" },
				documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "rounded" } },
				accept = { auto_brackets = {
					enabled = true,
				} },
				list = { selection = { preselect = false, auto_insert = false } },
				menu = {
					border = "rounded",
					auto_show = true,
					draw = {
						columns = {
							{ "kind_icon", "kind", gap = 1 },
							{ "label", "label_description", gap = 1 },
						},
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
							kind_icon = {
								text = function(ctx)
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										icon = require("lspkind").symbolic(ctx.kind, {
											mode = "symbol",
										})
									end

									return icon .. ctx.icon_gap
								end,

								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},
						},
					},
				},
			},
			signature = { enabled = true, window = { border = "rounded" } },
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<C-y>"] = { "select_and_accept", "fallback" },
				["<CR>"] = { "select_and_accept", "fallback" },

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"accept",
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },

				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
			cmdline = {
				keymap = { preset = "inherit", ["<CR>"] = { "fallback" } },
				completion = {
					ghost_text = { enabled = true },
					menu = { auto_show = true },
				},
			},
		},
	},
}
