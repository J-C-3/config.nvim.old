Themes["nord"] = function()
    vim.g.nord_contrast = true
    vim.g.nord_borders = true
    vim.g.nord_disable_background = false
    vim.g.nord_enable_sidebar_background = true
    vim.g.nord_cursorline_transparent = false
    vim.g.nord_italic = true

    require('nord').set()

    vim.cmd('highlight CursorLine guibg=' .. Util.darken(Util.getColor("Normal", "bg#"), 0.8))
end

Themes["zephyr"] = function()
    require('zephyr')
end

Themes["dracula"] = function()
    vim.cmd[[colorscheme dracula]]
end

Themes["tokyodark"] = function()
    vim.g.tokyodark_transparent_background = false
    vim.g.tokyodark_enable_italic_comment = true
    vim.g.tokyodark_enable_italic = true
    vim.g.tokyodark_color_gamma = "1.3" -- I wish everyone did this
    vim.cmd("colorscheme tokyodark")
end

Themes["monokai"] = function()
    require('monokai').setup {}
    -- require('monokai').setup { palette = require('monokai').pro }
    -- require('monokai').setup { palette = require('monokai').soda }
    -- require('monokai').setup { palette = require('monokai').ristretto }
end

-- Themes.gruvbox()
-- Themes.kanagawa()
-- Themes.nord()
-- Themes.zephyr()
-- Themes.dracula()
-- Themes.tokyodark()
Themes.monokai()
