-- Nvim config
local packerInstall = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

require('util')
require('plugins')
if vim.fn.empty(vim.fn.glob(packerInstall)) == 0 then
    Util.extraConfs('defaults.d')
    Util.extraConfs('user.d')
end
