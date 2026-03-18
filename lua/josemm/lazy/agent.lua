return {
	{
		"nickjvandyke/opencode.nvim",
		version = "*", -- Latest stable release
		config = function()
			local opencode = require("opencode")
			vim.g.opencode_opts = {
				server = {
					port = OpenCodePort,
					start = function()
						vim.fn.jobstart(
							("zellij action new-pane --name opencode -- opencode --port %d"):format(OpenCodePort),
							{ detach = true }
						)
					end,
					stop = function()
						vim.fn.jobstart(("pkill -f 'opencode --port %d'"):format(OpenCodePort), { detach = true })
					end,
					toggle = function()
						vim.fn.jobstart("zellij action focus-next-pane", { detach = true })
					end,
				},
			}

			vim.o.autoread = true

			vim.keymap.set({ "n", "x" }, "<leader>aa", function()
				opencode.ask("@this: ", { submit = true })
			end, { desc = "Ask opencode…" })
			vim.keymap.set({ "n", "x" }, "<leader>aA", function()
				opencode.select()
			end, { desc = "Execute opencode action…" })

			vim.keymap.set({ "n", "x" }, "<leader>al", function()
				return opencode.operator("@this ")
			end, { desc = "Add range to opencode", expr = true })

			vim.keymap.set("n", "<leader>all", function()
				return opencode.operator("@this ") .. "_"
			end, { desc = "Add line to opencode", expr = true })
		end,
	},
}
