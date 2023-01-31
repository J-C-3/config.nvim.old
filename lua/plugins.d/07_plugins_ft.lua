plugins.ft = {
    {
        "chrisbra/csv.vim",
        ft = { "csv" },
    },

    {
        "rust-lang/rust.vim",
        ft = { "rust" },
    },

    {
        "sirtaj/vim-openscad",
        ft = { "openscad" },
    },

    {
        "plasticboy/vim-markdown",
        ft = { "markdown" },
        config = function()
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_no_default_key_mappings = 1
            vim.g.vim_markdown_conceal = 1
            vim.g.vim_markdown_conceal_code_blocks = 0
            vim.g.vim_markdown_strikethrough = 1
        end
    },

    {
        "ray-x/go.nvim",
        ft = { "go" },
        config = true
    },
    {
        "jakewvincent/mkdnflow.nvim",
        ft = { "markdown" },
        config = function()
            require("mkdnflow").setup({
                links = {
                    transform_explicit = function(text)
                        -- Make lowercase, remove spaces, and reverse the string
                        return string.lower(text:gsub(" ", "_"))
                    end,
                },
                mappings = {
                    MkdnEnter = { { "n", "v" }, "<CR>" },
                    MkdnTab = false,
                    MkdnSTab = false,
                    MkdnNextLink = false,
                    MkdnPrevLink = false,
                    MkdnNextHeading = { "n", "]]" },
                    MkdnPrevHeading = { "n", "[[" },
                    MkdnGoBack = { "n", "<BS>" },
                    MkdnGoForward = { "n", "<Del>" },
                    MkdnFollowLink = false, -- see MkdnEnter
                    MkdnDestroyLink = { "n", "<M-CR>" },
                    MkdnTagSpan = { "v", "<M-CR>" },
                    MkdnMoveSource = { "n", "<F2>" },
                    MkdnYankAnchorLink = { "n", "ya" },
                    MkdnYankFileAnchorLink = { "n", "yfa" },
                    MkdnIncreaseHeading = { "n", "+" },
                    MkdnDecreaseHeading = { "n", "-" },
                    MkdnToggleToDo = { { "n", "v" }, "<C-Space>" },
                    MkdnNewListItem = false,
                    MkdnNewListItemBelowInsert = { "n", "o" },
                    MkdnNewListItemAboveInsert = { "n", "O" },
                    MkdnExtendList = false,
                    MkdnUpdateNumbering = { "n", "<leader>nn" },
                    MkdnTableNextCell = { "i", "<Tab>" },
                    MkdnTablePrevCell = { "i", "<S-Tab>" },
                    MkdnTableNextRow = false,
                    MkdnTablePrevRow = { "i", "<M-CR>" },
                    MkdnTableNewRowBelow = { "n", "<leader>ir" },
                    MkdnTableNewRowAbove = { "n", "<leader>iR" },
                    MkdnTableNewColAfter = { "n", "<leader>ic" },
                    MkdnTableNewColBefore = { "n", "<leader>iC" },
                    MkdnFoldSection = false,
                    MkdnUnfoldSection = false,
                },
            })
        end
    },
}
