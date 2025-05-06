local kind_icons = {
	Avante = "󰭹",
	Copilot = "",
	Function = "󰊕",
	Enum = "󰕲",
}

return {
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
		dependencies = {
			"Kaiser-Yang/blink-cmp-avante",
			"echasnovski/mini.icons",
			"philosofonusus/ecolog.nvim",
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
			"kristijanhusak/vim-dadbod-completion",
		},
		opts = {
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-y>"] = { "accept_and_enter", "fallback" },
				["<Tab>"] = {
					function(cmp)
						cmp.accept()
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
			cmdline = {
				enabled = true,
				keymap = {
					preset = "none",
					["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-e>"] = { "hide", "fallback" },
					["<CR>"] = { "fallback" },
					["<C-y>"] = { "accept_and_enter", "fallback" },
					["<Tab>"] = {
						"accept",
					},
					["<S-Tab>"] = { "snippet_backward", "fallback" },
					["<Up>"] = { "select_prev", "fallback" },
					["<Down>"] = { "select_next", "fallback" },
					["<C-p>"] = { "select_prev", "fallback_to_mappings" },
					["<C-n>"] = { "select_next", "fallback_to_mappings" },
					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },
					["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
				},
				completion = {
					menu = { auto_show = true },
					ghost_text = { enabled = true },
				},
			},
			sources = {
				default = { "avante", "ecolog", "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					sql = { "snippets", "dadbod", "snippets", "buffer" },
				},
				providers = {
					ecolog = { name = "ecolog", module = "ecolog.integrations.cmp.blink_cmp" },
					buffer = {
						opts = {
							get_bufnrs = function()
								return vim.tbl_filter(function(bufnr)
									return vim.bo[bufnr].buftype == ""
								end, vim.api.nvim_list_bufs())
							end,
						},
					},
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
					},
					cmdline = {
						min_keyword_length = function(ctx)
							if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
								return 3
							end
							return 0
						end,
					},
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
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
									return kind_icons[ctx.kind] or kind_icon
								end,
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
				list = { selection = { preselect = false, auto_insert = true } },
				trigger = {
					show_in_snippet = true,
				},
			},
			signature = { window = { border = "rounded" }, enabled = true },
			fuzzy = { implementation = "rust" },
		},
		opts_extend = { "sources.default" },
	},
}
