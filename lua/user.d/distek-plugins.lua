local use = require('packer').use

use 'tpope/vim-fugitive'

use {
    'shaunsingh/nord.nvim',
}

use {
    "folke/zen-mode.nvim",
    config = function()
        require("zen-mode").setup(
            {
                window = {
                    backdrop = 0.95,
                    width = 120,
                    height = 1, -- >1 dicates height of the actual window
                    options = {
                        signcolumn = "no",
                        number = false,
                        relativenumber = false,
                        cursorline = false,
                        cursorcolumn = false,
                        foldcolumn = "0",
                        list = false,
                    },
                },
                plugins = {
                    options = {
                        enabled = true,
                        ruler = false,
                        showcmd = false,
                    },
                    twilight = { enabled = true },
                    gitsigns = { enabled = false },
                    tmux = { enabled = false },
                },
                on_open = function(win)
                    -- can be used to completely disable/enable completion and lsp diags
                    -- vim.cmd[[LspStop]]
                    -- require('cmp').setup.buffer { enabled = false }
                end,
                on_close = function()
                    -- vim.cmd[[LspStart]]
                    -- require('cmp').setup.buffer { enabled = true }
                end,
            }
        )
    end
}

use {
    "folke/twilight.nvim",
    config = function()
        require("twilight").setup(
            {
                dimming = {
                    alpha = 0.25,
                    color = { "Normal", "#ffffff" },
                    inactive = false,
                },
                context = 10,
                treesitter = true,
                expand = {
                    "function",
                    "method",
                    "table",
                    "if_statement",
                },
                exclude = {},
            }
        )
    end
}
