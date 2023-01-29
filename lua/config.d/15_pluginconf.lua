require("nvim-treesitter").setup({
    ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "devicetree",
        "dockerfile",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "graphql",
        "help",
        "html",
        "htmldjango",
        "http",
        "javascript",
        "json",
        "jsonnet",
        "JSON with comments",
        "jq",
        "llvm",
        "lua", 
        "make",
        "markdown",
        "markdown_inline",
        "perl",
        "php",
        "phpdoc",
        "python",
        "racket",
        "ruby",
        "rust",
        "sql",
        "swift",
        "todotxt",
        "toml",
        "typescript",
        "vim", 
        "yaml",
    },
    sync_install = false,
})
require("lualine").setup({
     options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
})
require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls", 
        "clangd",
        "dockerls",
        "gopls",
        "jsonls",
        "tsserver",
        "jsonnet_ls",
        "sumneko_lua",
        "marksman",
        "jedi_language_server",
        "taplo",
        "lemminx",
    },
})
require("mason-lspconfig").setup_handlers{
    function (server_name)
        require("lspconfig")[server_name].setup {}
    end,
}
local cmp = require("cmp")
require("cmp").setup({
    sources = cmp.config.sources(cmpTable.sources)
    })
