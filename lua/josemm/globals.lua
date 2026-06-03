local function find_project_root()
	local dir = vim.uv.cwd()

	while dir ~= nil do
		if vim.uv.fs_stat(string.format("%s/.git", dir)) ~= nil then
			return dir
		end

		local parent = vim.fs.dirname(dir)
		if parent == nil or parent == dir then
			break
		end

		dir = parent
	end

	return vim.uv.cwd()
end

local function merge_tool_config(defaults, overrides)
	local result = vim.deepcopy(defaults)

	for name, override in pairs(overrides or {}) do
		if type(result[name]) == "table" and type(override) == "table" then
			result[name] = vim.tbl_deep_extend("force", result[name], override)
		else
			result[name] = override
		end
	end

	return result
end

local function set_disabled(items, names, disabled)
	for _, name in ipairs(names) do
		if type(items[name]) == "table" then
			items[name].disabled = disabled
		end
	end
end

local function split_csv(value)
	if value == nil or value == "" then
		return {}
	end

	local result = {}
	for _, item in ipairs(vim.split(value, ",", { trimempty = true })) do
		table.insert(result, vim.trim(item):lower())
	end

	return result
end

ProjectRoot = find_project_root()

local default_lsps = {
	bashls = { install = "bash-language-server" },
	ty = { install = "ty" },
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
	angularls = { install = "angular-language-server" },
	tsgo = { install = "tsgo" },
	biome = { install = "biome" },
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

local default_formatters = {
	biome = {
		install = "biome",
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
	rustfmt = {
		install = nil,
		filetypes = { "rust" },
	},
	nufmt = {
		install = nil,
		filetypes = { "nu" },
	},
}

function GetLsps()
	local lsps = merge_tool_config(default_lsps)
	set_disabled(lsps, split_csv(vim.env.NVIM_DISABLE), true)
	set_disabled(lsps, split_csv(vim.env.NVIM_ENABLE), false)
	return lsps
end

function GetFormatters()
	local formatters = merge_tool_config(default_formatters)
	set_disabled(formatters, split_csv(vim.env.NVIM_DISABLE), true)
	set_disabled(formatters, split_csv(vim.env.NVIM_ENABLE), false)
	return formatters
end

Lsps = GetLsps()
Formatters = GetFormatters()

OpenCodePort = 40000 + (vim.fn.getpid() % 10000)
