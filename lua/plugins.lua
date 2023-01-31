plugins = vim.defaulttable()

Util.extraConfs("plugins.d")
require("lazy").setup(Util.FlattenList(plugins))
