require("go").setup()

function Org_imports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            print(r)
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit)
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end

-- function Codeaction(action, only, wait_ms)
--     wait_ms = wait_ms or 1000
--     local params = vim.lsp.util.make_range_params()
--     if only then
--         params.context = {only = {only}}
--     end
--     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
--     if not result or next(result) == nil then
--         return
--     end
--     for _, res in pairs(result) do
--         for _, r in pairs(res.result or {}) do
--             if r.edit and not vim.tbl_isempty(r.edit) then
--                 local result = vim.lsp.util.apply_workspace_edit(r.edit)
--             end
--             if type(r.command) == "table" then
--                 if type(r.command) == "table" and r.command.arguments then
--                     for _, arg in pairs(r.command.arguments) do
--                         if action == nil or arg['Fix'] == action then
--                             vim.lsp.buf.execute_command(r.command)
--                             return
--                         end
--                     end
--                 end
--             end
--         end
--     end
-- end

-- _G.goIfErr = function()
--     local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
--     vim.api.nvim_feedkeys([[oif err != nil {
-- return
-- }]]..esc.."kA ", "nt", true)
-- end

-- _G.goFillStruct = function()
--     Codeaction('fill_struct', 'refactor.rewrite', 1000)
-- end
