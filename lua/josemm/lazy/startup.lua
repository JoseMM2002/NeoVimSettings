local getPokemon = function()
	local pokemon = require("pokemon")
	local env_pokemon_size = require("dotenv").get_env_var("POKEMON_SIZE")
	local favorite_pokemons = {
		"0155", -- Cyndaquil
		"0156", -- Quilava
		"0157", -- Typhlosion
		"0001", -- Bulbasaur
		"0158", -- Totodile
		"0004", -- Charmander
		"0152", -- Chikorita
		"0246", -- Larvitar
		"0248", -- Tyranitar
		"0658", -- Greninja
		"0909", -- Fuecoco
		"0392", -- Infernape
		"0007", -- Squirtle
		"0483", -- Dialga
		"0383", -- Groudon
		"0384", -- Rayquaza
		"0491", -- Darkrai
		"0395", -- Empoleon
		"0389", -- Torterra
		"0503", -- Samurott
		"0376", -- Metagross
		"0784", -- Kommo-o
		"0445", -- Garchomp
		"0887", -- Dragapult
		"0258", -- Mudkip
	}
	local random_pokemon = favorite_pokemons[math.random(#favorite_pokemons)]
	pokemon.setup({ number = random_pokemon, size = env_pokemon_size or "large" })
	return pokemon.header()
end

local theme = function()
	local vim_version = vim.version()
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
		footer = {
			title = "Neovim Version",
			type = "text",
			content = { "Neovim v" .. vim_version.major .. "." .. vim_version.minor .. "." .. vim_version.patch },
			align = "center",
			fold_section = false,
			margin = 5,
			highlight = "Number",
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
		parts = { "header", "body", "footer" },
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
		vim.api.nvim_set_keymap("n", "<F6>", "<cmd>PokemonTogglePokedex<cr>", {
			noremap = true,
			desc = "PokemonTogglePokedex",
		})
	end,
}
