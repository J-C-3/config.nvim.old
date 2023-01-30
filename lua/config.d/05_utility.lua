CmpRegistry = vim.defaulttable()
-- TODO: Move functions elsewhere and trim them down
-- Simple function to dump tables for troubleshooting
function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        if type(o) == "function" then
            local info = debug.getinfo(o, "Sln")
            if info.what == "C" then -- is a C function?
                o = string.format("%s: %s", tostring(o) .. "C function")
            else -- a Lua function
                o = string.format("[%s] %s: %s",
                    info.short_src, "Fn: ", info.name)
            end
        end
        return tostring(o)
    end
end

plugins = vim.defaulttable()
-- Simple function to add values to nvim-cmp `setup` function
-- TODO: vim.tbl_extend & vim.tbl_deep_extend & vim.defaulttable?
cmpTable = {
    sources = {},
    mreh = {},
}
-- function cmpSetup(tbl)
--     local cmp = require("cmp")
--     for k, v in pairs(tbl) do
--         if k == "sources" then
--             table.insert(cmpTable.mreh, v)
--             cmpTable.sources = cmp.config.sources(cmpTable.mreh)
--         else
--             if cmpTable[k] == nil then
--                 cmpTable[k] = v
--             else
--                 table.insert(cmpTable[k], v)
--             end
--         end
--     end
-- end
--
--TODO WIP
function KeyFromTable(k, o, t)
    if t == nil then
        local t = {}
    end
    for i, v in pairs(o) do
        if i == k then
            vim.list_extend(t, v)
        elseif type(v) == table then
        end
        return t
    end
end

function FlattenLists(o, t)
    if t == nil then
        t = {}
    end
    for _, v in pairs(o) do
        vim.list_extend(t, v)
    end
    return t
end

-- require("lazy").setup({
--     {
--         "dstein64/vim-startuptime",
--         cmd = "StartupTime",
--     },
-- })
