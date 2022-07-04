vim.g.themes = {}

vim.g.themes["kanagawa"] = function()
    local conf = {
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        variablebuiltinStyle = { italic = true },
        specialReturn = true, -- special highlight for the return keyword
        specialException = true, -- special highlight for exception handling keywords
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        globalStatus = true, -- adjust window separators highlight for laststatus=3
        colors = {},
        overrides = {},
    }

    require('kanagawa').setup(conf)

    vim.cmd("colorscheme kanagawa")

    vim.cmd('highlight NvimTreeNormal guibg=' .. Darken(Util.getColor("Normal", "bg#"), 0.6))
    vim.cmd('highlight NvimTreeNormalNC guibg=' .. Darken(Util.getColor("Normal", "bg#"), 0.6))
    vim.cmd('highlight Terminal guibg=' .. Darken(Util.getColor("Normal", "bg#"), 0.5))
end

vim.g.themes["gruvbox"] = function()
    vim.g.gruvbox_bold = 1
    vim.g.gruvbox_italic = 1
    vim.g.gruvbox_transparent_bg = 1
    vim.g.gruvbox_underline = 1
    vim.g.gruvbox_undercurl = 1
    vim.g.gruvbox_termcolors = 0
    vim.g.gruvbox_contrast_dark = "medium"
    vim.g.gruvbox_contrast_light = "medium"
    vim.g.gruvbox_hls_cursor = "orange"
    vim.g.gruvbox_number_column = "bg1"
    vim.g.gruvbox_sign_column = "bg2"
    vim.g.gruvbox_color_column = "bg2"
    vim.g.gruvbox_vert_split = "bg0"
    vim.g.gruvbox_italicize_comments = 1
    vim.g.gruvbox_italicize_strings = 0
    vim.g.gruvbox_invert_selection = 0
    vim.g.gruvbox_invert_signs = 0
    vim.g.gruvbox_invert_indent_guides = 0
    vim.g.gruvbox_invert_tabline = 0
    vim.g.gruvbox_improved_strings = 0
    vim.g.gruvbox_improved_warnings = 0
    vim.g.gruvbox_guisp_fallback = 'NONE'

    vim.cmd[[highlight link TSError Normal]]

    vim.cmd("colorscheme gruvbox")

    vim.cmd('highlight NvimTreeNormal guibg='..Darken(Util.getColor("Normal", "bg#"), 0.8))
end
