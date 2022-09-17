-- Util
Util = {}

-- Searches for lua files within a provided path in the
-- nvim runtime paths
Util.extraConfs = function(path)
    local extraConfigs = vim.api.nvim_get_runtime_file("*/" .. path .. "/*", true)

    if #extraConfigs > 0 then
        for _, f in ipairs(extraConfigs) do
            dofile(f)
        end
    end
end

-- Returns to previous position in file
Util.line_return = function()
    local line = vim.fn.line

    if line("'\"") > 0 and line("'\"") <= line("$") then
        vim.cmd("normal! g`\"zvzz'")
    end
end


function len(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

-- Skips over quickfix buf when tabbing through buffers
-- Reason: QF appears to overwrite the <Tab> mappings
Util.skipQFAndTerm = function(dir)
    if dir == "prev" then
        require"cokeline/mappings".by_step("focus", "-1")

        local buftype = vim.api.nvim_buf_get_option(0, "buftype")

        if buftype == "quickfix" or buftype == "terminal" then
            if buftype == "terminal" then
                -- if the terminal is not open elsewhere
                if len(vim.fn.win_findbuf(vim.fn.bufnr('%'))) == 1 then
                    return
                end

                vim.cmd[[stopinsert]]

                return
            end

            Util.skipQFAndTerm(dir)
        end
    else
        require"cokeline/mappings".by_step("focus", '1')

        local buftype = vim.api.nvim_buf_get_option(0, "buftype")

        if buftype == "quickfix" or buftype == "terminal" then
            if buftype == "terminal" then
                -- if the terminal is not open elsewhere
                if len(vim.fn.win_findbuf(vim.fn.bufnr('%'))) == 1 then
                    return
                end

                vim.cmd[[stopinsert]]

                return
            end

            Util.skipQFAndTerm(dir)
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

Util.tagbarToggle = function()
    vim.g.tagbarOpen = not vim.g.tagbarOpen

    vim.cmd [[TagbarToggle]]
end

Util.toggleTerm = function()
    local doWinCmd = false

    if vim.g.tagbarOpen then
        vim.cmd [[TagbarToggle]]
    end

    vim.cmd [[ToggleTerm]]

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

Util.darken = function(hex, amount)
    return blend(hex, utilbg, math.abs(amount))
end

Util.lighten = function(hex, amount)
    return blend(hex, utilfg, math.abs(amount))
end

Util.getColor = function(group, attr)
    return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end
