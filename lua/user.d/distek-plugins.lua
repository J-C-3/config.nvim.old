local use = require('packer').use

use 'tpope/vim-fugitive'

use {
    'shaunsingh/nord.nvim',
}

use {
  "folke/zen-mode.nvim",
  config = function()
    require("zen-mode").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}
