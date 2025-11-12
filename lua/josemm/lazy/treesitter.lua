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
				{ suffix = "a", name = "outer" },
				{ suffix = "i", name = "inner" },
				{ suffix = "r", name = "return" },
			},
		},
	},
	{
		suffix = "c",
		textobject = {
			"call",
			{
				{ suffix = "a", name = "outer" },
				{ suffix = "i", name = "inner" },
			},
		},
	},
	{
		suffix = "/",
		textobject = {
			"comment",
			{
				{ suffix = "a", name = "outer" },
				{ suffix = "i", name = "inner" },
			},
		},
	},
	{
		suffix = "@",
		textobject = {
			"decorator",
			{
				{ suffix = "a", name = "outer" },
				{ suffix = "i", name = "inner" },
			},
		},
	},
	{
		suffix = "?",
		textobject = {
			"conditional",
			{
				{ suffix = "a", name = "outer" },
				{ suffix = "i", name = "inner" },
			},
		},
	},
	{
		suffix = "b",
		textobject = {
			"block",
			{
				{ suffix = "a", name = "outer" },
				{ suffix = "i", name = "inner" },
			},
		},
	},
	{
		suffix = "p",
		textobject = {
			"param",
			{
				{ suffix = "a", name = "outer" },
				{ suffix = "i", name = "inner" },
				{ suffix = "t", name = "type" },
			},
		},
	},
	{
		suffix = "=",
		textobject = {
			"set",
			{
				{ suffix = "a", name = "outer" },
				{ suffix = "r", name = "rhs" },
				{ suffix = "l", name = "lhs" },
				{ suffix = "t", name = "type" },
			},
		},
	},
	{
		suffix = "q",
		textobject = {
			"quote",
			{
				{ suffix = "a", name = "outer" },
				{ suffix = "i", name = "inner" },
			},
		},
	},
	{
		suffix = "r",
		textobject = {
			"return",
			{
				{ suffix = "a", name = "outer" },
				{ suffix = "i", name = "inner" },
			},
		},
	},
	{
		suffix = "o",
		textobject = {
			"object",
			{
				{ suffix = "a", name = "outer" },
				{ suffix = "i", name = "inner" },
				{ suffix = "f", name = "field" },
				{ suffix = "p", name = "key" },
				{ suffix = "v", name = "value" },
				{ suffix = "t", name = "type" },
				{ suffix = "s", name = "scope" },
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
					end)
					vim.keymap.set("n", "m" .. motion, function()
						next(composed_object)
					end)
					vim.keymap.set("n", "M" .. motion, function()
						previous(composed_object)
					end)
				end
			end
		end,
	},
}
