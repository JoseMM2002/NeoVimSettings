local ensure_installed = {
	"vimdoc",
	"javascript",
	"typescript",
	"angular",
	"c",
	"lua",
	"rust",
	"jsdoc",
	"bash",
	"python",
	"css",
	"html",
	"go",
	"cpp",
	"scss",
	"java",
	"prisma",
	"vue",
	"tsx",
	"zig",
	"yaml",
	"json",
	"nu",
	"dockerfile",
	"gitcommit",
	"git_rebase",
	"gitattributes",
	"gitignore",
	"gomod",
	"jsdoc",
	"json5",
	"jsonc",
	"jsx",
	"luadoc",
	"markdown",
	"markdown_inline",
	"nginx",
	"prisma",
	"scss",
	"sql",
	"ssh_config",
	"vim",
	"xml",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			require("nvim-treesitter").install(ensure_installed)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = ensure_installed,
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		branch = "main",
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						["@class.outer"] = "<c-v>", -- blockwise
					},
					include_surrounding_whitespace = false,
				},
			})

			local select = require("nvim-treesitter-textobjects.select").select_textobject

			-- Functions
			vim.keymap.set({ "x", "o" }, "af", function()
				select("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "if", function()
				select("@function.inner", "textobjects")
			end)

			--Calls
			vim.keymap.set({ "x", "o" }, "ac", function()
				select("@call.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ic", function()
				select("@call.outer", "textobjects")
			end)

			-- Classes
			vim.keymap.set({ "x", "o" }, "aC", function()
				select("@class.outer", "textobjects")
			end, { desc = "Around class" })
			vim.keymap.set({ "x", "o" }, "iC", function()
				select("@class.inner", "textobjects")
			end, { desc = "Inside class" })

			-- Loops
			vim.keymap.set({ "x", "o" }, "al", function()
				select("@loop.outer", "textobjects")
			end, { desc = "Around loop" })
			vim.keymap.set({ "x", "o" }, "il", function()
				select("@loop.inner", "textobjects")
			end, { desc = "Inside loop" })

			-- Comments
			vim.keymap.set({ "x", "o" }, "a/", function()
				select("@comment.outer", "textobjects")
			end, { desc = "Around comment" })
			vim.keymap.set({ "x", "o" }, "i/", function()
				select("@comment.inner", "textobjects")
			end, { desc = "Inside comment" })

			-- Attributes / decorators
			vim.keymap.set({ "x", "o" }, "a@", function()
				select("@attribute.outer", "textobjects")
			end, { desc = "Around attribute/decorator" })
			vim.keymap.set({ "x", "o" }, "i@", function()
				select("@attribute.inner", "textobjects")
			end, { desc = "Inside attribute/decorator" })

			-- Frames (try/catch/with depending on language queries)
			vim.keymap.set({ "x", "o" }, "aF", function()
				select("@frame.outer", "textobjects")
			end, { desc = "Around frame" })
			vim.keymap.set({ "x", "o" }, "iF", function()
				select("@frame.inner", "textobjects")
			end, { desc = "Inside frame" })

			-- Conditionals
			vim.keymap.set({ "x", "o" }, "a?", function()
				select("@conditional.outer", "textobjects")
			end, { desc = "Around conditional" })
			vim.keymap.set({ "x", "o" }, "i?", function()
				select("@conditional.inner", "textobjects")
			end, { desc = "Inside conditional" })

			--Blocks
			vim.keymap.set({ "x", "o" }, "ab", function()
				select("@block.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ib", function()
				select("@block.inner", "textobjects")
			end)

			--Scope
			vim.keymap.set({ "x", "o" }, "as", function()
				select("@local.scope", "locals")
			end)

			-- Parameters
			vim.keymap.set({ "x", "o" }, "ip", function()
				select("@parameter.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ap", function()
				select("@parameter.outer", "textobjects")
			end)

			-- Assignments
			vim.keymap.set({ "x", "o" }, "a=", function()
				select("@assignment.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "r=", function()
				select("@assignment.rhs", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "i=", function()
				select("@assignment.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "l=", function()
				select("@assignment.lhs", "textobjects")
			end)

			-- Quotes
			vim.keymap.set({ "x", "o" }, "aq", function()
				select("@quote.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "iq", function()
				select("@quote.inner", "textobjects")
			end)
		end,
	},
}
