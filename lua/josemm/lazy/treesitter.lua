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

local queries_objects = {
	{
		suffix = "f",
		textobject = {
			"function",
			{
				{ suffix = "a", name = "outer", description = "around function" },
				{ suffix = "i", name = "inner", description = "inside function" },
				{ suffix = "r", name = "return", description = "function return type" },
			},
		},
	},
	{
		suffix = "c",
		textobject = {
			"call",
			{
				{ suffix = "a", name = "outer", description = "around call" },
				{ suffix = "i", name = "inner", description = "inside call" },
			},
		},
	},
	{
		suffix = "/",
		textobject = {
			"comment",
			{
				{ suffix = "a", name = "outer", desciption = "around comment" },
				{ suffix = "i", name = "inner", description = "inside comment" },
			},
		},
	},
	{
		suffix = "@",
		textobject = {
			"decorator",
			{
				{ suffix = "a", name = "outer", description = "around decorator" },
				{ suffix = "i", name = "inner", description = "inside decorator" },
			},
		},
	},
	{
		suffix = "?",
		textobject = {
			"conditional",
			{
				{ suffix = "a", name = "outer", description = "around conditional" },
				{ suffix = "i", name = "inner", description = "inside conditional" },
			},
		},
	},
	{
		suffix = "b",
		textobject = {
			"block",
			{
				{ suffix = "a", name = "outer", description = "around block" },
				{ suffix = "i", name = "inner", description = "inside block" },
			},
		},
	},
	{
		suffix = "a",
		textobject = {
			"param",
			{
				{ suffix = "a", name = "outer", description = "around parameter" },
				{ suffix = "i", name = "inner", description = "inside parameter" },
				{ suffix = "t", name = "type", description = "parameter type" },
			},
		},
	},
	{
		suffix = "=",
		textobject = {
			"set",
			{
				{ suffix = "a", name = "outer", description = "around assignment" },
				{ suffix = "r", name = "rhs", description = "right-hand side" },
				{ suffix = "l", name = "lhs", description = "left-hand side" },
				{ suffix = "t", name = "type", description = "assigned type" },
			},
		},
	},
	{
		suffix = "q",
		textobject = {
			"quote",
			{
				{ suffix = "a", name = "outer", description = "around quotes" },
				{ suffix = "i", name = "inner", description = "inside quotes" },
			},
		},
	},
	{
		suffix = "r",
		textobject = {
			"return",
			{
				{ suffix = "a", name = "outer", description = "around return" },
				{ suffix = "i", name = "inner", description = "inside return" },
			},
		},
	},
	{
		suffix = "o",
		textobject = {
			"object",
			{
				{ suffix = "a", name = "outer", description = "around object" },
				{ suffix = "i", name = "inner", description = "inside object" },
				{ suffix = "f", name = "field", description = "object field" },
				{ suffix = "e", name = "key", description = "object key" },
				{ suffix = "v", name = "value", description = "object value" },
				{ suffix = "t", name = "type", description = "object type" },
				{ suffix = "s", name = "scope", description = "object scope" },
			},
		},
	},
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
					include_surrounding_whitespace = true,
				},
				move = {
					set_jumps = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select").select_textobject
			local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
			local next = require("nvim-treesitter-textobjects.move").goto_next_start
			local previous = require("nvim-treesitter-textobjects.move").goto_previous_start

			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

			for _, obj in ipairs(queries_objects) do
				local textobject = obj.textobject[1]
				for _, part in ipairs(obj.textobject[2]) do
					local composed_object = "@" .. textobject .. "." .. part.name
					local motion = part.suffix .. obj.suffix
					vim.keymap.set({ "x", "o" }, motion, function()
						select(composed_object, "textobjects")
					end, { desc = part.description })
					vim.keymap.set("n", "m" .. motion, function()
						next(composed_object)
					end, { desc = part.description })
					vim.keymap.set("n", "M" .. motion, function()
						previous(composed_object)
					end, { desc = part.description })
				end
			end
		end,
	},
}
