plugins.ui = {
    { "lewis6991/gitsigns.nvim" },
    { "powerman/vim-plugin-AnsiEsc" },
    { "kwkarlwang/bufresize.nvim" },
    {
        "noib3/nvim-cokeline", -- TODO: what _is_ cokeline and check setup details
        dependencies = "kyazdani42/nvim-web-devicons",
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme gruvbox]])
        end,
    },
    {
        "nvim-lualine/lualine.nvim", -- TODO: jacob is fancy and usually has cool bars
        dependencies = "kyazdani42/nvim-web-devicons",
        config={     
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {},
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            extensions = {}
        }
    },
}
