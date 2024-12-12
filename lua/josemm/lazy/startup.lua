local getPokemon = function()
	local pokemon = require("pokemon")
	local favorite_pokemons = { "0155", "0156", "0157", "0001", "0158", "0004", "0152" }
	local random_pokemon = favorite_pokemons[math.random(#favorite_pokemons)]
	pokemon.setup({ number = random_pokemon, size = "large" })
	return pokemon.header()
end

local theme = function()
	return {
		-- every line should be same width without escaped \
		header = {
			type = "text",
			oldfiles_directory = false,
			align = "center",
			fold_section = false,
			title = "Header",
			margin = 5,
			content = getPokemon(),
			highlight = "Statement",
			default_color = "",
			oldfiles_amount = 0,
		},
		-- name which will be displayed and command
		body = {
			type = "mapping",
			oldfiles_directory = false,
			align = "center",
			fold_section = false,
			title = "Basic Commands",
			margin = 5,
			content = {
				{ " Find File", "Telescope find_files", "<leader>ff" },
				{ "󰍉 Find Word", "Telescope live_grep", "<leader>fr" },
				{ " Find Buffers", "Telescope buffers", "<leader>fb" },
				{ " Colorschemes", "Themery", "<leader>tc" },
			},
			highlight = "String",
			default_color = "",
			oldfiles_amount = 0,
		},
		options = {
			mapping_keys = true,
			cursor_column = 0.5,
			empty_lines_between_mappings = true,
			disable_statuslines = true,
			paddings = { 1, 3, 3, 0 },
		},
		mappings = {
			execute_command = "<CR>",
			open_file = "o",
			open_file_split = "<c-o>",
			open_section = "<TAB>",
			open_help = "?",
		},
		colors = {
			background = "#1f2227",
			folded_section = "#56b6c2",
		},
		parts = { "header", "body" },
	}
end
return {
	"startup-nvim/startup.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"ColaMint/pokemon.nvim",
	},
	config = function()
		local settings = theme()
		require("startup").setup(settings)
	end,
}
