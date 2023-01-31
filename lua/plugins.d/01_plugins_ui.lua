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
        config = {
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
    {
        "distek/bufferline.nvim",
        branch = "tabpage-rename",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
            "famiu/bufdelete.nvim",
        },
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers", -- set to "tabs" to only show tabpages instead
                    numbers = "none",
                    close_command = "lua require('bufdelete').bufdelete(0, true)", -- can be a string | function, see "Mouse actions"
                    right_mouse_command = "", -- can be a string | function, see "Mouse actions"
                    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
                    middle_mouse_command = "lua require('bufdelete').bufdelete(0, true)", -- can be a string | function, see "Mouse actions"
                    indicator = {
                        icon = "▎", -- this should be omitted if indicator style is not 'icon'
                        style = "icon",
                    },
                    buffer_close_icon = "",
                    modified_icon = "●",
                    close_icon = "",
                    left_trunc_marker = "",
                    right_trunc_marker = "",
                    max_name_length = 18,
                    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
                    truncate_names = true, -- whether or not tab names should be truncated
                    tab_size = 18,
                    diagnostics = "nvim_lsp",
                    diagnostics_update_in_insert = false,
                    -- NOTE: this will be called a lot so don't do any heavy processing here
                    -- custom_filter = function(buf_number, buf_numbers)
                    --     -- filter out filetypes you don't want to see
                    --     if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
                    --         return true
                    --     end
                    --     -- filter out by buffer name
                    --     if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
                    --         return true
                    --     end
                    --     -- filter out based on arbitrary rules
                    --     -- e.g. filter out vim wiki buffer from tabline in your work repo
                    --     if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                    --         return true
                    --     end
                    --     -- filter out by it's index number in list (don't show first buffer)
                    --     if buf_numbers[1] ~= buf_number then
                    --         return true
                    --     end
                    -- end,
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "Neovim",
                            highlight = "Explorer",
                            text_align = "center",
                            padding = 1,
                        },
                    },
                    color_icons = true, -- whether or not to add the filetype icon highlights
                    show_buffer_icons = true, -- disable filetype icons for buffers
                    show_buffer_close_icons = true,
                    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
                    show_close_icon = true,
                    show_tab_indicators = true,
                    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
                    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                    -- can also be a table containing 2 custom separators
                    -- [focused and unfocused]. eg: { '|', '|' }
                    separator_style = "thick",
                    always_show_bufferline = true,
                    -- hover = {
                    --     enabled = true,
                    --     delay = 200,
                    --     reveal = {'close'}
                    -- },
                    -- sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
                    -- add custom logic
                    -- return buffer_a.modified > buffer_b.modified
                    -- end
                },
            })
        end
    },
}
