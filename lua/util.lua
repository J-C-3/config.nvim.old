-- Util
Util = vim.defaulttable()

Util.extraConfs = function(path)
    local extraConfigs = vim.api.nvim_get_runtime_file("*/" .. path .. "/*", true)
    if #extraConfigs > 0 then
        for _, f in ipairs(extraConfigs) do
            dofile(f)
        end
    end
end

Util.extraConfs("util.d")
