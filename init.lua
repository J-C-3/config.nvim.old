-- Nvim config
if vim.g.vscode then
    require('vscode')
else
    local packerInstall = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

    vim.o.runtimepath = vim.o.runtimepath .. ',' .. vim.fn.stdpath("data") .. "/packer/"

    require('util')
    require('plugins')
    if vim.fn.empty(vim.fn.glob(packerInstall)) == 0 then
        Util.extraConfs('defaults.d')
        Util.extraConfs('user.d')
    end
end
