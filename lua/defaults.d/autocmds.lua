-- Autocommands

-- Compile packer on save of nvim's init.lua
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*/nvim/init.lua", "*/nvim/lua/*.lua" },
    callback = function()
        os.execute("rm " .. vim.fn.expand("~") .. "/.config/nvim/plugin/packer_compiled.lua")
        require("packer").compile()
    end
})

-- Return to previous line in file
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = { "*" },
    callback = function()
        Util.line_return()
    end
})

-- Return to previous line in file
vim.api.nvim_create_autocmd("BufNewFile,BufRead", {
    pattern = { "*.ha" },
    callback = function()
        vim.notify("asdf")
        vim.cmd [[:set syntax=cpp]]
    end
})

-- LSP - documentHighlight
-- highlight - normal
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = { "<buffer>" },
    callback = function()
        local clients = vim.lsp.get_active_clients()

        if not next(clients) then
            return
        end

        if clients[1].server_capabilities.documentHighlightProvider then
            vim.lsp.buf.document_highlight()
        end
    end
})

-- highlight - insert
vim.api.nvim_create_autocmd("CursorHoldI", {
    pattern = { "<buffer>" },
    callback = function()
        local clients = vim.lsp.get_active_clients()

        if not next(clients) then
            return
        end

        if clients[1].server_capabilities.documentHighlightProvider then
            vim.lsp.buf.document_highlight()
        end
    end
})

-- highlight clear on move
vim.api.nvim_create_autocmd("CursorMoved", {
    pattern = { "<buffer>" },
    callback = function()
        vim.lsp.buf.clear_references()
    end
})

vim.api.nvim_create_autocmd("FocusGained", {
    pattern = { "*" },
    callback = function()
        vim.cmd [[checktime]]
    end
})

vim.api.nvim_create_autocmd("FocusGained", {
    pattern = { "*" },
    callback = function()
        vim.cmd [[checktime]]
    end
})

-- Deal with quickfix
-- set nobuflisted and close if last window
vim.api.nvim_create_augroup("qf", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf" },
    callback = function()
        vim.o.buflisted = false
    end,
    group = "qf",
})

vim.api.nvim_create_autocmd("WinEnter", {
    pattern = { "*" },
    callback = function()
        if vim.fn.winnr('$') == 1 and vim.bo.buftype == "quickfix" then
            vim.cmd [[q]]
        end
    end,
    group = "qf",
})

-- Terminal
vim.api.nvim_create_augroup("Terminal", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "term://*" },
    callback = function()
        vim.cmd [[startinsert]]
    end,
    group = "Terminal",
})

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = { "*" },
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.wrap = true
        vim.opt_local.list = true
        vim.opt_local.signcolumn = "no"
    end,
    group = "Terminal",
})

vim.api.nvim_create_autocmd("TermClose", {
    pattern = { "*" },
    callback = function()
        vim.cmd(':call feedkeys("i")')
    end,
    group = "Terminal",
})
-- I am putting off rewriting this
vim.cmd [[
    function! NeatFoldText()
        let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
        let lines_count = v:foldend - v:foldstart + 1
        let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
        let foldchar = matchstr(&fillchars, 'fold:\zs.')
        let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
        let foldtextend = lines_count_text . repeat(foldchar, 8)
        let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
        return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
    endfunction
    
    set foldtext=NeatFoldText()
]]

vim.cmd [[
    augroup markdown
        setlocal spell
    augroup end
]]
