Lsps = {
	bashls = { install = "bash-language-server" },
	basedpyright = { install = "basedpyright" },
	clangd = { install = "clangd" },
	cssls = { install = "css-lsp" },
	eslint = { install = "eslint-lsp" },
	gopls = { install = "gopls" },
	gradle_ls = { install = "gradle-language-server" },
	html = { install = "html-lsp" },
	jdtls = { install = "jdtls" },
	jsonls = { install = "json-lsp" },
	lua_ls = { install = "lua-language-server" },
	postgres_lsp = { install = "postgres-language-server" },
	prismals = { install = "prisma-language-server" },
	rust_analyzer = { install = "rust-analyzer" },
	somesass_ls = { install = "some-sass-language-server" },
	tailwindcss = { install = "tailwindcss-language-server" },
	vtsls = { install = "vtsls" },
	vue_ls = { install = "vue-language-server" },
	zls = { install = "zls" },
	nushell = { install = nil },
	angularls = { install = "angular-language-server", disabled = true },
}

Capabilities = {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
		completion = {
			completionItem = {
				snippetSupport = true,
			},
		},
	},
	documentSymbolProvider = true,
}

Formatters = {
	prettier = {
		install = "prettier",
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
		install = "rustywind",
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
		install = "stylua",
		filetypes = { "lua" },
	},
	taplo = {
		install = "taplo",
		filetypes = { "toml" },
	},
	shfmt = {
		install = "shfmt",
		filetypes = { "sh" },
	},
	sql_formatter = {
		install = "sql-formatter",
		filetypes = { "sql" },
	},
	gofmt = {
		install = nil,
		filetypes = { "go" },
	},
}
