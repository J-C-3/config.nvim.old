local api = vim.api
vim.wo.colorcolumn = "0"


-- Float a focused window
function Float()
    -- Allow it to fail if the window can't be floated
    if len(api.nvim_list_wins()) < 2
    then
        print("Float() can only be used if there is more than one window")
        return
    end

    local curWin = api.nvim_get_current_win()
    local ui = api.nvim_list_uis()[1]

    local width, height = math.floor(ui.width / 2), math.floor(ui.height / 2)
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
end
