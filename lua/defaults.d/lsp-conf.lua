local lspconfig = require('lspconfig')

vim.diagnostic.config({
    virtual_text = true,
})

-- Formatting
-- Map :Format to vim.lsp.buf.formatting()
vim.cmd [[command! Format execute 'lua vim.lsp.buf.format { async = true }']]

-- Aesthetics
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type

    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- lsp-installer
require("mason").setup({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    ensure_installed = { "bashls", "clang", "gopls", "sumneko_lua" },
    automatic_installation = true,
})

require("mason-lspconfig").setup_handlers({
    function(server_name)
        lspconfig[server_name].setup {}
    end,
    ["tsserver"] = function()
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
    end,
    ["gopls"] = function()
        lspconfig.gopls.setup {
            root_dir = lspconfig.util.root_pattern("go.mod", ".git", "main.go")
        }
    end,
})
