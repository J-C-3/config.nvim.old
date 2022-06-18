-- Nvim config
local packerInstall = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

require('util')
require('plugins')
if vim.fn.empty(vim.fn.glob(packerInstall)) == 0 then
    require('globals')
    require('autocmds')
    require('lsp-conf')
    require('mappings')
end
