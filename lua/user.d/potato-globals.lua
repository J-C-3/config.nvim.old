local api = vim.api
vim.wo.colorcolumn = "0"


function floatFromCurBuf(closeCurWin)
    local curBuf = api.nvim_get_current_buf()
    local curWin = api.nvim_get_current_win()
    local ui = api.nvim_list_uis()[1]

    local width, height = math.floor(ui.width / 1.5), math.floor(ui.height / 2)
    local opts = { relative = "editor",
        width = width,
        height = height,
        col = math.floor(ui.width / 2) - math.floor(width / 2),
        row = math.floor(ui.height / 2) - math.floor(height / 2),
        anchor = "NW",
        style = "",
    }
    api.nvim_open_win(curBuf, true, opts)
    if closeCurWin == true
    then
        api.nvim_win_close(curWin, false)
    end
end
