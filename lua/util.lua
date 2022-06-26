-- Util
Util = {}

Util.newTerm = function()
    if vim.fn.winnr('$') > 1 then
        vim.cmd("split term://" .. Vimterm)
        return
    else
        vim.cmd("vsplit term://" .. Vimterm)
        return
    end
end

Util.line_return = function()
    local line = vim.fn.line

    if line("'\"") > 0 and line("'\"") <= line("$") then
        vim.cmd("normal! g`\"zvzz'")
    end
end

-- Skips over quickfix buf when tabbing through buffers
Util.skipQF = function(dir)
    if dir == "prev" then
        vim.cmd [[lua require"cokeline/mappings".by_step("focus", -1)]]
    else
        vim.cmd [[lua require"cokeline/mappings".by_step("focus", 1)]]
    end

    while vim.api.nvim_buf_get_option(0, "buftype") == "quickfix" do
        if dir == "prev" then
            vim.cmd [[lua require"cokeline/mappings".by_step("focus", -1)]]

            -- I have no idea why this is needed
            vim.cmd [[stopinsert]]
        else
            vim.cmd [[lua require"cokeline/mappings".by_step("focus", 1)]]

            vim.cmd [[stopinsert]]
        end
    end
end

-- Useful for determining highlight names
vim.cmd [[
function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
]]

Util.dapStop = function()
    local dap = require('dap')
    local dapui = require('dapui')

    if dap.session() then
        dap.disconnect()
    end

    dap.close()
    dapui.close()
end

Util.nvimTreeToggle = function()
    vim.g.nvimtreeOpen = not vim.g.nvimtreeOpen

    require 'nvim-tree'.toggle()
end

Util.tagbarToggle = function()
    vim.g.tagbarOpen = not vim.g.tagbarOpen

    vim.cmd [[TagbarToggle]]
end

Util.toggleTerm = function()
    local doWinCmd = false

    local nvimTree = require "nvim-tree"
    local nvimTreeView = require "nvim-tree.view"

    if vim.g.nvimtreeOpen then
        nvimTreeView.close()
    end

    if vim.g.tagbarOpen then
        vim.cmd [[TagbarToggle]]
    end

    vim.cmd [[ToggleTerm]]

    if vim.g.nvimtreeOpen then
        doWinCmd = true
        nvimTree.toggle()
    end

    if vim.g.tagbarOpen then
        doWinCmd = true
        vim.cmd [[TagbarToggle]]
    end

    if doWinCmd then
        vim.cmd [[silent wincmd p]]
    end
end

local utilbg = "#000000"
local utilfg = "#ffffff"

local function hexToRgb(hex_str)
    local hex = "[abcdef0-9][abcdef0-9]"
    local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
    hex_str = string.lower(hex_str)

    assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

    local r, g, b = string.match(hex_str, pat)
    return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

local function blend(fg, bg, alpha)
    bg = hexToRgb(bg)
    fg = hexToRgb(fg)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

function Darken(hex, amount)
    return blend(hex, utilbg, math.abs(amount))
end

function Lighten(hex, amount)
    return blend(hex, utilfg, math.abs(amount))
end

Util.getColor = function(group, attr)
    return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end

function LazygitFloat()
    local cfg = {
        ft = 'lazygit',
        cmd = Vimterm .. " -c lazygit",
        auto_close = false,
        dimensions = {
            height = 0.9, -- Height of the terminal window
            width = 0.9, -- Width of the terminal window
        },
    }

    local term = require('FTerm'):new(cfg)

    term:open()
end
