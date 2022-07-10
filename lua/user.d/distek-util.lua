Util.newTerm = function()
    if vim.fn.winnr('$') > 1 then
        vim.cmd("split term://" .. Vimterm)
        return
    else
        vim.cmd("vsplit term://" .. Vimterm)
        return
    end
end

