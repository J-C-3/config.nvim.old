if vim.g.vscode then
    require('vscode')
else
    vim.o.runtimepath = vim.o.runtimepath .. ',' .. vim.fn.stdpath("data") .. "/packer/"

    local firstRun = require('plugins')

    if firstRun then
        require('packer').sync()
    else
        require('util')

        Util.extraConfs('defaults.d')
        Util.extraConfs('user.d')
    end
end
