return {
	{
		"nickjvandyke/opencode.nvim",
		version = "*", -- Latest stable release
		config = function()
			vim.g.opencode_opts = {
				server = {
					port = OpenCodePort,

					-- Open a new Zellij pane running opencode
					start = function() end,

					-- Kill the opencode process (Zellij pane will close on its own)
					stop = function() end,

					-- Focus the opencode Zellij pane by name
					toggle = function() end,
				},
			}

			vim.o.autoread = true -- Required for `opts.events.reload`

			-- Recommended/example keymaps
			vim.keymap.set({ "n", "x" }, "<leader>aa", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode…" })
			vim.keymap.set({ "n", "x" }, "<leader>aA", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })

			vim.keymap.set({ "n", "x" }, "<leader>al", function()
				return require("opencode").operator("@this ")
			end, { desc = "Add range to opencode", expr = true })

			vim.keymap.set("n", "<leader>all", function()
				return require("opencode").operator("@this ") .. "_"
			end, { desc = "Add line to opencode", expr = true })
		end,
	},
}
