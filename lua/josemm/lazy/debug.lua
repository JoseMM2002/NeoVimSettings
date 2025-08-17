local continue = function()
	if vim.fn.filereadable(".vscode/launch.json") then
		vim.notify("Loading launch.json from .vscode directory", vim.log.levels.INFO)
		require("dap.ext.vscode").load_launchjs()
	end
	require("dap").continue()
end

local function get_args()
	local args_string = vim.fn.input("Program arguments: ")
	if args_string == "" then
		return {}
	end
	-- Simply split by space for array format that DAP expects
	return vim.split(args_string, " ")
end

local enter_launch_url = function()
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

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})
		require("nvim-dap-virtual-text").setup()

		dap.set_log_level("DEBUG")

		dap.adapters = {
			gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			},
			["pwa-node"] = {
				type = "server",
				port = "${port}",
				executable = {
					command = "dapDebugServer.js",
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
					command = "dapDebugServer.js",
					args = {
						"${port}",
						"127.0.0.1",
					},
				},
			},
		}

		for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file with node",
					program = "${file}",
					cwd = "${workspaceFolder}",
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
					userDataDir = "${workspaceFolder}/.vscode/chrome-debug-profile",
					breakOnLoad = true,
					pathMapping = {
						["/"] = "${workspaceFolder}/client/",
					},
				},
			}
		end

		dap.configurations.c = {
			{
				name = "Launch",
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
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				pid = function()
					local name = vim.fn.input("Executable name (filter): ")
					return require("dap.utils").pick_process({ filter = name })
				end,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Attach to gdbserver :1234",
				type = "gdb",
				request = "attach",
				target = "localhost:1234",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
		}
		dap.configurations.cpp = dap.configurations.c
		dap.configurations.rust = dap.configurations.c

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", continue, { desc = "Continue debugging" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step out" })
		vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Terminate debug session" })
		vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart debug session" })
		vim.keymap.set("n", "<leader>dU", function()
			require("dapui").toggle()
		end, { desc = "Toggle debug UI" })
	end,
}
