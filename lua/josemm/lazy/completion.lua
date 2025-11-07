local kind_icons = {
	Avante = "󰭹",
	Copilot = "",
}

return {
	{
		"philosofonusus/ecolog.nvim",
		opts = {
			integrations = {
				nvim_cmp = true,
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
			require("luasnip").filetype_extend("vue", { "typescript", "javascript", "html", "css" })
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",

			"onsails/lspkind.nvim",
			"nvim-tree/nvim-web-devicons",
			"philosofonusus/ecolog.nvim",
			"L3MON4D3/LuaSnip",
			"kristijanhusak/vim-dadbod-completion",
			"zbirenbaum/copilot-cmp",
			"saadparwaiz1/cmp_luasnip",
		},
		event = { "InsertEnter", "CmdlineEnter" },

		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			lspkind.init({
				symbol_map = kind_icons,
			})

			cmp.setup({
				sources = {
					{
						name = "nvim_lsp",
						priority = 1000,
					},
					{ name = "luasnip", priority = 900 },
					{
						name = "ecolog",
						priority = 800,
					},
					{
						name = "copilot",
						priority = 10,
					},
					{
						name = "buffer",
						get_bufnrs = function()
							return vim.api.nvim_list_bufs()
						end,
						priority = 5,
					},
					{ name = "nvim_lsp_document_symbol" },
					{ name = "nvim_lsp_signature_help" },
					{
						name = "path",
					},
				},

				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = function(entry, vim_item)
						local kind = lspkind.cmp_format({
							mode = "symbol_text",
						})(entry, vim.deepcopy(vim_item))
						local highlights_info = require("colorful-menu").cmp_highlights(entry)
						if highlights_info ~= nil then
							vim_item.abbr_hl_group = highlights_info.highlights
							vim_item.abbr = highlights_info.text
						end
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						vim_item.kind = " " .. (strings[1] or "") .. " "
						vim_item.menu = ""
						return vim_item
					end,
				},

				window = {
					completion = { border = "rounded" },
					documentation = { border = "rounded" },
				},

				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping(function(fallback)
						local entry = cmp.get_selected_entry()
						if entry then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({
									behavior = cmp.ConfirmBehavior.Replace,
									select = false,
								})
							end
						else
							fallback()
						end
					end),
					["<Tab>"] = cmp.mapping(function(fallback)
						if luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							cmp.abort()
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				experimental = {
					ghost_text = true,
				},

				preselect = cmp.PreselectMode.None,
			})

			local cmdline_preset = cmp.mapping.preset.cmdline({
				["<Tab>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
					c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmdline_preset,
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmdline_preset,
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
