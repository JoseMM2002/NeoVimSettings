MasonLsps = {
	["angular-language-server"] = nil,
	["basedpyright"] = "basedpyright",
	["bash-language-server"] = "bashls",
	["clangd"] = "clangd",
	["css-lsp"] = "cssls",
	["eslint-lsp"] = "eslint",
	["gopls"] = "gopls",
	["gradle-language-server"] = "gradle_ls",
	["html-lsp"] = "html",
	["jdtls"] = "jdtls",
	["json-lsp"] = "jsonls",
	["lua-language-server"] = "lua_ls",
	["postgres-language-server"] = "postgres_lsp",
	["prisma-language-server"] = "prismals",
	["rust-analyzer"] = "rust_analyzer",
	["some-sass-language-server"] = "somesass_ls",
	["tailwindcss-language-server"] = "tailwindcss",
	["vtsls"] = "vtsls",
	["vue-language-server"] = "vue_ls",
	["zls"] = "zls",
}

LocalLsps = {
	"nushell",
}

Capabilities = {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
}

Formatters = {
	prettier = {
		name = "prettier",
		filetypes = {
			"javascript",
			"typescript",
			"vue",
			"javascriptreact",
			"typescriptreact",
			"html",
			"css",
			"json",
			"jsonc",
			"scss",
			"markdown",
			"sass",
			"yaml",
		},
	},
	rustywind = {
		name = "rustywind",
		filetypes = {
			"javascript",
			"typescript",
			"vue",
			"javascriptreact",
			"typescriptreact",
			"html",
			"css",
			"json",
			"jsonc",
			"scss",
			"markdown",
			"sass",
			"yaml",
		},
	},
	stylua = {
		name = "stylua",
		filetypes = { "lua" },
	},
	taplo = {
		name = "taplo",
		filetypes = { "toml" },
	},
	shfmt = {
		name = "taplo",
		filetypes = { "sh" },
	},
	sql_formatter = {
		name = "sql-formatter",
		filetypes = { "sql" },
	},
	gofmt = {
		name = nil,
		filetypes = { "go" },
	},
}
