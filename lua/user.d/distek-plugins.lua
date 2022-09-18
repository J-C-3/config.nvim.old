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
                        number = true,
                        relativenumber = true,
                        cursorline = true,
                        cursorcolumn = false,
                        foldcolumn = "0",
                        list = false,
                    },
                },
                plugins = {
                    options = {
                        enabled = true,
                        ruler = true,
                        showcmd = true,
                    },
                    twilight = { enabled = false },
                    gitsigns = { enabled = true },
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

-- like limelight
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

use {
    'rmagatti/auto-session',
    config = function()
        require('auto-session').setup {
            log_level = 'error',
            auto_session_suppress_dirs = {
                vim.fn.expand("~/"),
                vim.fn.expand("~/") .. '/Projects',
            }
        }
    end
}

use({
    'glepnir/zephyr-nvim',
    requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
})

use 'Mofiqul/dracula.nvim'

use 'tiagovla/tokyodark.nvim'

use 'tanvirtin/monokai.nvim'
