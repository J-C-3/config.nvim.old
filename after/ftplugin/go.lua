vim.api.nvim_create_augroup("Go", { clear = true })

local opts = { noremap = true, silent = true }
local map = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, opts)
end

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*go" },
    callback = function()
        map("n", "<leader>Gfs", ":GoFillStruct<cr>")
        map("n", "<leader>Gie", ":GoIfErr<cr>")
        map("n", "<leader>Gr", " :GoRun")
        map("n", "<leader>Gt", " :GoTest")
        map("n", "<leader>Gat", ":GoAddTest<cr>")
    end,
    group = "Go",
})

-- Add test for function under cursor
-- Args:
--     open: bool - opens test file after function creation
function GoAddTest(open)
    local function getBaseFilename(line)
        local ret, _ = line:gsub(".go$", "")
        return ret
    end

    local function subRootDir(root, path)
        local ret, _ = path:gsub(root.."/", "")
        return ret
    end

    -- get buffer info (funcName, path)
    local bufNumber = vim.api.nvim_get_current_buf()

    local bufPath = vim.api.nvim_buf_get_name(bufNumber)

    local ts = require("nvim-treesitter.ts_utils")

    local current_node = ts.get_node_at_cursor()
    if not current_node then
        return
    end

    local expr = current_node

    while expr do
        if expr:type() == 'function_declaration' then
            break
        end
        expr = expr:parent()
    end

    if expr == nil then
        print("Apparently could not find parent")
        return
    end

    local funcName = ts.get_node_text(expr:child(1))

    if funcName == nil or funcName == "" then
        return
    end
    local subRoot = subRootDir(vim.lsp.buf.list_workspace_folders()[1], bufPath)
    -- pathSubGo - name without the .go ext
    local pathSubGo = getBaseFilename(subRoot)

    -- run gotests -only ..funcName.. -w ..pathSubGo.._test.go
    --
    local ret = os.execute("gotests -only \"^" .. funcName[1] .. "$\" -w ".. pathSubGo.."_test.go ".. pathSubGo ..".go ", 'r')


    if open then
        vim.cmd("edit " .. pathSubGo .. "_test.go")
    end
end

vim.api.nvim_create_user_command("GoAddTest", "lua GoAddTest(true)", {})
