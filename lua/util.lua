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

function len(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end


-- Float() is a helper function to make a currently focused window float
-- Adjust the size of your window by setting FloatHeightDivisor & FloatWidthDivisor in your config
function Float(floatWidthDivisor, floatHeightDivisor)
    -- Allow it to fail if the window can't be floated
    if len(api.nvim_list_wins()) < 2 then
        print('Float() can only be used if there is more than one window')
        return
    end

    local curWin = api.nvim_get_current_win()
    local ui = api.nvim_list_uis()[1]

    -- Allow the divisor to be set elsewhere
    local heightDivisor, widthDivisor = 2, 2
    if floatWidthDivisor then
        widthDivisor = floatWidthDivisor
    end
    if floatHeightDivisor then
        heightDivisor = floatHeightDivisor
    end

    local width, height = math.floor(ui.width / widthDivisor), math.floor(ui.height / heightDivisor)
    local quadBufHeight = api.nvim_buf_line_count(api.nvim_get_current_buf()) * 4

    -- Ensure the window is not ridiculously large for the content
    if quadBufHeight < height then
        height = quadBufHeight
    end

    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        col = math.floor(ui.width / 2) - math.floor(width / 2),
        row = math.floor(ui.height / 2) - math.floor(height / 2),
        anchor = 'NW',
        style = 'minimal',
        border = 'shadow',
    }
    api.nvim_win_set_option(curWin, 'winhighlight', 'Normal:FloatWinCustom')

    api.nvim_win_set_config(curWin, opts)
    return curWin
end
