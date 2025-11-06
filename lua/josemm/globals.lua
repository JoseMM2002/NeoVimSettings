MasonLsps = {
	"vtsls",
	"rust_analyzer",
	"gopls",
	"basedpyright",
	"html",
	"tailwindcss",
	"bashls",
	"lua_ls",
	"jsonls",
	"cssls",
	"zls",
	"somesass_ls",
	"jdtls",
	"gradle_ls",
	"prismals",
	"clangd",
	"vue_ls",
	"eslint",
	"angularls",
}

DisabledLsps = {
	"angularls",
}

LocalLsps = {
	"nushell",
	"postgres_lsp",
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
	rustywind = {
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
	stylua = {
		"lua",
	},
	taplo = {
		"toml",
	},
	shfmt = {
		"sh",
	},
	sql_formatter = {
		"sql",
	},
	gofmt = {
		"go",
	},
}
