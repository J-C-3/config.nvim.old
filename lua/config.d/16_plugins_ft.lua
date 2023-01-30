plugins.ft={
    { "chrisbra/csv.vim",
        ft = { "csv" },
        lazy = true,
    },

    { "rust-lang/rust.vim",
        ft = { "rust" },
        lazy = true,
    },

    { "sirtaj/vim-openscad",
        ft = { "openscad" },
        lazy = true,
    },

    { "plasticboy/vim-markdown",
        ft = { "markdown" },
        lazy = true,
        config = function()
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_no_default_key_mappings = 1
            vim.g.vim_markdown_conceal = 1
            vim.g.vim_markdown_conceal_code_blocks = 0
            vim.g.vim_markdown_strikethrough = 1
        end
    },

    { "ray-x/go.nvim",
        ft = { "go" },
        lazy = true,
        config = function()
            require("go").setup()
        end
    },
}
