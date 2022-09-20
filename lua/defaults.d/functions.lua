local api = vim.api
-- Float() is a helper function to make a currently focused window float
-- Adjust the size of your window by setting FloatHeightDivisor & FloatWidthDivisor in your config
function Float()
    -- Allow it to fail if the window can't be floated
    if len(api.nvim_list_wins()) < 2
    then
        print("Float() can only be used if there is more than one window")
        return
    end

    local curWin = api.nvim_get_current_win()
    local ui = api.nvim_list_uis()[1]

    -- Allow the divisor to be set elsewhere
    local heightDivisor, widthDivisor = 2, 2
    if FloatHeightDivisor then
        heightDivisor = FloatHeightDivisor
    end
    if FloatWidthDivisor then
        widthDivisor = FloatWidthDivisor
    end

    local width, height = math.floor(ui.width / widthDivisor), math.floor(ui.height / heightDivisor)
    local doubleBufHeight = api.nvim_buf_line_count(api.nvim_get_current_buf()) * 4

    -- Ensure the window is not ridiculously large for the content
    if doubleBufHeight < height
    then
        height = doubleBufHeight
    end

    local opts = { relative = "editor",
        width = width,
        height = height,
        col = math.floor(ui.width / 2) - math.floor(width / 2),
        row = math.floor(ui.height / 2) - math.floor(height / 2),
        anchor = "NW",
        style = "minimal",
        border = "shadow",
    }
    -- Make it purtier
    vim.cmd('highlight FloatWinCustom guibg=' .. Util.lighten(Util.getColor("Normal", "bg#"), 0.95))
    api.nvim_win_set_option(curWin, "winhighlight", "Normal:FloatWinCustom")

    api.nvim_win_set_config(curWin, opts)
    return curWin
end
