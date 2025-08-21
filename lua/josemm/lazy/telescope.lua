return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "AckslD/nvim-neoclip.lua",
        "nvim-telescope/telescope-frecency.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        { "nvim-tree/nvim-web-devicons", opts = {} },
        {
            "isak102/telescope-git-file-history.nvim",
            dependencies = {
                "tpope/vim-fugitive",
            },
        },
    },
    config = function()
        local builtin = require("telescope.builtin")
        local lga_actions = require("telescope-live-grep-args.actions")
        local gfh_actions = require("telescope").extensions.git_file_history.actions

        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<Esc>"] = "close",
                    },
                },
            },
            extensions = {
                undo = {
                    side_by_side = true,
                    layout_strategy = "vertical",
                    layout_config = {
                        preview_height = 0.8,
                    },
                    mappings = {
                        i = {
                            ["<cr>"] = require("telescope-undo.actions").yank_additions,
                            ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                            ["<C-cr>"] = require("telescope-undo.actions").restore,
                            ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
                            ["<C-r>"] = require("telescope-undo.actions").restore,
                        },
                        n = {
                            ["y"] = require("telescope-undo.actions").yank_additions,
                            ["Y"] = require("telescope-undo.actions").yank_deletions,
                            ["u"] = require("telescope-undo.actions").restore,
                        },
                    },
                },
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    -- define mappings, e.g.
                    mappings = {         -- extend mappings
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                        },
                    },
                },
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                },
                git_file_history = {
                    mappings = {
                        i = {
                            ["<C-g>"] = gfh_actions.open_in_browser,
                        },
                        n = {
                            ["<C-g>"] = gfh_actions.open_in_browser,
                        },
                    },
                    browser_command = nil,
                },
            },
        })

        require("neoclip").setup({})

        vim.keymap.set("n", "<leader>fu", function()
            require("telescope").extensions.undo.undo()
        end, { desc = "Browse undo history" })

        vim.keymap.set("n", "<leader>ff", function()
            builtin.find_files({ hidden = true })
        end, { desc = "Find files (including hidden)" })

        vim.keymap.set("n", "<leader>fb", function()
            require("telescope.builtin").buffers({ sort_lastused = true })
        end, { desc = "Find buffers (sorted by last used)" })

        vim.keymap.set("n", "<leader>fr", function()
            require("telescope.builtin").live_grep({})
        end, { desc = "Search text in files" })

        vim.keymap.set("n", "<leader>fht", function()
            builtin.help_tags({})
        end, { desc = "Search help documentation" })

        vim.keymap.set("n", "<leader>fs", function()
            require("telescope.builtin").git_status({
                git_icons = {
                    changed = "",
                    added = "",
                    renamed = "",
                    unmerged = "",
                    deleted = "",
                    untracked = "",
                    copied = "󰬸",
                },
            })
        end, { desc = "Git status" })

        vim.keymap.set("n", "<leader>fn", function()
            require("telescope").extensions.neoclip.default()
        end, { desc = "Neoclip (clipboard history)" })

        vim.keymap.set("n", "<leader>fdg", function()
            require("telescope.builtin").diagnostics()
        end, { desc = "Search all diagnostics" })

        vim.keymap.set("n", "<leader>fd", function()
            require("telescope.builtin").diagnostics({
                bufnr = 0,
            })
        end, { desc = "Search buffer diagnostics" })

        vim.keymap.set("n", "<leader>fls", function()
            require("telescope.builtin").lsp_document_symbols()
        end, { noremap = true, silent = true, desc = "Search document symbols" })

        vim.keymap.set("n", "gr", function()
            require("telescope.builtin").lsp_references()
        end, { noremap = true, silent = true, desc = "Find symbol references" })

        vim.keymap.set("n", "gd", function()
            require("telescope.builtin").lsp_definitions()
        end, { noremap = true, silent = true, desc = "Go to symbol definition" })

        vim.keymap.set("n", "<leader>tc", function()
            require("telescope.builtin").colorscheme({ enable_preview = true })
        end, { desc = "Browse colorschemes" })

        vim.keymap.set("n", "<leader>fh", function()
            require("telescope").extensions.git_file_history.git_file_history()
        end, { noremap = true, silent = true, desc = "Git file history" })

        require("telescope").load_extension("neoclip")
        require("telescope").load_extension("undo")
        require("telescope").load_extension("live_grep_args")
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("git_file_history")
        require("telescope").load_extension("frecency")
    end,
}
