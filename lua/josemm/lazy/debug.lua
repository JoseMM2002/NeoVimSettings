local continue = function()
	require("dap").continue()
end

local function get_args()
	local args_string = vim.fn.input("Program arguments: ")
	if args_string == "" then
		return {}
	end

	return vim.split(args_string, " ")
end

local function resolve_executable(env, env_var, fallback)
	local env_path = env.var(env_var)
	if env_path and env_path ~= "" then
		return env_path
	end

	local executable_path = vim.fn.exepath(fallback)
	if executable_path ~= nil and executable_path ~= "" then
		return executable_path
	end

	return fallback
end

local function enter_launch_url()
	local co = coroutine.running()
	return coroutine.create(function()
		vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:" }, function(url)
			if url == nil or url == "" then
				return
			else
				coroutine.resume(co, url)
			end
		end)
	end)
end

local function get_highlight_fg(groups, fallback)
	for _, group in ipairs(groups) do
		local ok, highlight = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
		if ok and highlight and highlight.fg then
			return string.format("#%06x", highlight.fg)
		end
	end

	return fallback
end

local function set_dap_signs()
	local breakpoint_fg = get_highlight_fg({
		"DiagnosticVirtualTextError",
		"DiagnosticSignError",
		"DiagnosticError",
	}, "#ff5f5f")
	local stopped_fg = get_highlight_fg({
		"DiagnosticVirtualTextWarn",
		"DiagnosticSignWarn",
		"DiagnosticWarn",
	}, "#ffcc66")
	local info_fg = get_highlight_fg({
		"DiagnosticVirtualTextInfo",
		"DiagnosticSignInfo",
		"DiagnosticInfo",
	}, "#7dcfff")

	vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = breakpoint_fg, bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = breakpoint_fg, bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = breakpoint_fg, bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "DapStopped", { fg = stopped_fg, bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "DapLogPoint", { fg = info_fg, bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "NONE" })

	vim.fn.sign_define(
		"DapBreakpoint",
		{ text = "⬢", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" }
	)
	vim.fn.sign_define("DapBreakpointCondition", {
		text = "⬢",
		texthl = "DapBreakpointCondition",
		linehl = "",
		numhl = "DapBreakpointCondition",
	})
	vim.fn.sign_define("DapBreakpointRejected", {
		text = "",
		texthl = "DapBreakpointRejected",
		linehl = "",
		numhl = "DapBreakpointRejected",
	})
	vim.fn.sign_define(
		"DapLogPoint",
		{ text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "DapLogPoint" }
	)
	vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "", numhl = "DapStopped" })
end

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"igorlfs/nvim-dap-view",
	},
	config = function()
		local dap = require("dap")
		local dapview = require("dap-view")
		local env = require("dotenv")
		local gdb_path = resolve_executable(env, "GDB_PATH", "gdb")
		local lldb_path = resolve_executable(env, "LLDB_PATH", "lldb-dap")
		local dlv_path = resolve_executable(env, "DLV_PATH", "dlv")
		local dap_debug_server_path = resolve_executable(env, "DAP_DEBUG_SERVER_PATH", "dapDebugServer.js")

		set_dap_signs()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = set_dap_signs,
		})

		dapview.setup({
			winbar = {
				sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
			},
			windows = {
				size = 0.3,
				position = "right",
			},
			auto_toggle = true,
			virtual_text = {
				enabled = true,
			},
		})

		dap.set_log_level("DEBUG")

		dap.adapters = {
			gdb = {
				type = "executable",
				command = gdb_path,
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			},
			lldb = {
				type = "executable",
				command = lldb_path,
				name = "lldb",
			},
			["pwa-node"] = {
				type = "server",
				port = "${port}",
				executable = {
					command = dap_debug_server_path,
					args = {
						"${port}",
						"127.0.0.1",
					},
				},
			},
			["pwa-chrome"] = {
				type = "server",
				port = "${port}",
				executable = {
					command = dap_debug_server_path,
					args = {
						"${port}",
						"127.0.0.1",
					},
				},
			},
			go = function(callback, config)
				if config.mode == "remote" and config.request == "attach" then
					callback({
						type = "server",
						host = config.host or "127.0.0.1",
						port = config.port or "38697",
					})
				else
					callback({
						type = "server",
						port = "${port}",
						executable = {
							command = dlv_path,
							args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
							detached = vim.fn.has("win32") == 0,
						},
					})
				end
			end,
		}

		for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file with node",
					program = "${file}",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to process using Node.js (nvim-dap)",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					name = "Launch file with ts-node",
					type = "pwa-node",
					request = "launch",
					cwd = "${workspaceFolder}",
					runtimeArgs = { "--loader", "ts-node/esm", "${file}" },
					runtimeExecutable = "node",
					sourceMaps = true,
					protocol = "inspector",
					skipFiles = { "node_modules/**", "<node_internals>/**" },
					resolveSourceMapLocations = {
						"${workspaceFolder}/**",
						"!**/node_modules/**",
					},
					console = "integratedTerminal",
				},
				{
					name = "Launch work file with ts-node",
					type = "pwa-node",
					request = "launch",
					cwd = "${workspaceFolder}",
					runtimeArgs = { "-r", "ts-node/register", "${file}" },
					runtimeExecutable = "node",
					sourceMaps = true,
					protocol = "inspector",
					skipFiles = { "node_modules/**", "<node_internals>/**" },
					resolveSourceMapLocations = {
						"${workspaceFolder}/**",
						"!**/node_modules/**",
					},
					console = "integratedTerminal",
				},
				{
					type = "pwa-chrome",
					name = "Launch Chrome to debug client",
					request = "launch",
					url = enter_launch_url,
					sourceMaps = true,
					protocol = "inspector",
					port = 9222,
					webRoot = "${workspaceFolder}/src",
					skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
				},
				{
					type = "pwa-chrome",
					name = "Launch Chrome to debug work client",
					request = "launch",
					url = enter_launch_url,
					webRoot = "${workspaceFolder}/client/src",
					sourceMapPathOverrides = {
						["webpack:///src/*"] = "${webRoot}/*",
						["webpack:///./src/*"] = "${webRoot}/*",
						["webpack:///./*"] = "${workspaceFolder}/client/*",
						["webpack:///./~/*"] = "${workspaceFolder}/client/node_modules/*",
						["webpack://?:*/*"] = "${workspaceFolder}/client/*",
					},
					runtimeArgs = {
						"--disable-web-security",
						"--disable-features=VizDisplayCompositor",
					},
					userDataDir = vim.fn.expand("~") .. "/.cache/vscode-chrome/",
					breakOnLoad = true,
					pathMapping = {
						["/"] = "${workspaceFolder}/client/",
					},
				},
			}
		end

		dap.configurations.c = {
			{
				name = "Launch with gdb",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
				args = get_args,
			},
			{
				name = "Launch with lldb",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = get_args,
				console = "integratedTerminal",
			},
		}
		dap.configurations.cpp = dap.configurations.c
		dap.configurations.rust = dap.configurations.c
		dap.configurations.zig = dap.configurations.c
		dap.configurations.go = {
			{
				type = "go",
				name = "Debug",
				request = "launch",
				showLog = true,
				program = "${file}",
				console = "integratedTerminal",
			},
			{
				name = "Launch Kualibot Server",
				type = "go",
				request = "launch",
				mode = "debug",
				program = "${workspaceFolder}/main.go",
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
			},
		}

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", continue, { desc = "Continue debugging" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step out" })
		vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Terminate debug session" })
		vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart debug session" })
		vim.keymap.set("n", "<leader>dU", function()
			require("dap-view").toggle()
		end, { desc = "Toggle debug UI" })
		vim.keymap.set({ "n", "v" }, "<leader>dw", function()
			require("dap-view").add_expr()
		end, { desc = "Add expression to watch list" })
	end,
}
