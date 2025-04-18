local kind_icons = {
	Avante = "󰭹",
	Copilot = "",
	Function = "󰊕",
	Enum = "󰕲",
}

local function has_value(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

local get_providers = function()
	local providers = { "avante", "ecolog", "lsp", "path", "snippets", "buffer" }
	local home = vim.fn.expand("~")
	local target_dirs = { home .. "/.config/nvim", home .. "/.config/kitty" }
	if has_value(target_dirs, vim.fn.getcwd()) then
		table.insert(providers, "nerdfont")
	end
	return providers
end

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
		dependencies = {
			"echasnovski/mini.icons",
			"philosofonusus/ecolog.nvim",
			"L3MON4D3/LuaSnip",
		},
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
			"MahanRahmati/blink-nerdfont.nvim",
		},
		opts = {
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-y>"] = { "accept", "fallback" },

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
			cmdline = {
				keymap = {
					preset = "none",
					["<Tab>"] = { "show", "select_next" },
					["<S-Tab>"] = { "show_and_insert", "select_prev" },
					["<C-space>"] = { "show", "fallback" },
					["<C-n>"] = { "select_next", "fallback" },
					["<C-p>"] = { "select_prev", "fallback" },
					["<Right>"] = { "select_next", "fallback" },
					["<Left>"] = { "select_prev", "fallback" },
					["<C-y>"] = { "select_and_accept" },
					["<C-e>"] = { "cancel" },
					["<CR>"] = { "accept_and_enter", "fallback" },
				},
				completion = { menu = { auto_show = true }, ghost_text = { enabled = false } },
			},
			sources = {
				default = get_providers(),
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
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
					},
					cmdline = {
						min_keyword_length = function(ctx)
							-- when typing a command, only show when the keyword is 3 characters or longer
							if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
								return 3
							end
							return 0
						end,
					},
					nerdfont = {
						module = "blink-nerdfont",
						name = "Nerd Fonts",
						score_offset = 15, -- Tune by preference
						opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
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
				list = { selection = { preselect = false } },
			},
			signature = { window = { border = "rounded" }, enabled = true },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
