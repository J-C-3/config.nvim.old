vim.api.nvim_create_augroup("Go", { clear = true })

local opts = { noremap = true, silent = true }
local map = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, opts)
end

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*go" },
    callback = function()
        map("n", "<leader>mk", ":mksession!")
        map("n", "<leader>Gfs", ":GoFillStruct<cr>")
        map("n", "<leader>Gie", ":GoIfErr<cr>")
        map("n", "<leader>Gr", " :GoRun")
        map("n", "<leader>Gt", " :GoTest")
        map("n", "<leader>Gat", ":GoAddTest<cr>")
    end,
    group = "Go",
})

