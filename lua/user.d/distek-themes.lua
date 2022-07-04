Themes["nord"] = function()
        vim.g.nord_contrast = true
        vim.g.nord_borders = true
        vim.g.nord_disable_background = false
        vim.g.nord_enable_sidebar_background = true
        vim.g.nord_cursorline_transparent = false
        vim.g.nord_italic = true

        require('nord').set()

        vim.cmd('highlight CursorLine guibg='..Darken(Util.getColor("Normal", "bg#"), 0.8))
    end

Themes.gruvbox()
-- Themes.kanagawa()
-- Themes.nord()
