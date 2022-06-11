-- LSP {{{

local lspconfig = require('lspconfig')

vim.diagnostic.config({
    virtual_text = true,
})

-- Formatting{{{
-- Map :Format to vim.lsp.buf.formatting()
FormattingOptions = {
    tabSize = 4,
    insertSpaces = true,
}

FormattingParams = vim.lsp.util.make_formatting_params(FormattingOptions)

vim.cmd [[command! Format execute 'lua vim.lsp.buf.formatting(FormattingParams)']]
--}}}

-- Aesthetics{{{
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type

    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
--}}}

-- lsp-installer{{{
local lsp_installer = require("nvim-lsp-installer")

-- Provide settings first!
lsp_installer.settings {
    automatic_installation = true,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

lsp_installer.on_server_ready(
    function(server)
        server:setup {}
    end
)
--}}}

-- Extra server config{{{
--
-- Typescript{{{
-- I have no idea if this works
lspconfig.tsserver.setup {
    cmd = { "npx", "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },

    init_options = {
        hostInfo = "neovim"
    },
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
}
--}}}

-- lua{{{
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, ".config/nvim/lua/?.lua")
table.insert(runtime_path, ".config/nvim/lua/?/init.lua")
--}}}

-- clangd {{{
require 'lspconfig'.clangd.setup {}
-- }}}

-- gopls {{{
lspconfig.gopls.setup {
    root_dir = lspconfig.util.root_pattern("go.mod", ".git", "main.go")
}
-- }}}

--}}}

-- }}}
