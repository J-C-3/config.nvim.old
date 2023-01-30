plugins.lsp = {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
        config = {
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
        }
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup {}
                end,
            }
        end
    },
    {
        "onsails/lspkind-nvim",
        config = function()
            local lspkind = require("lspkind")
            -- cmpSetup({
            --     formatting = {
            --         format = require("lspkind").cmp_format({
            --             with_text = true,
            --             maxwidth = 50,
            --             menu = {
            --                 buffer = "[Buffer]",
            --                 nvim_lsp = "[LSP]",
            --                 luasnip = "[Luasnip]",
            --                 nvim_lua = "[Lua]",
            --                 look = "[Look]",
            --                 spell = "[Spell]",
            --                 path = "[Path]",
            --                 calc = "[Calc]",
            --             },
            --         }),
            --     }
            -- })
        end
    },
    {
        'ray-x/lsp_signature.nvim',
        config = function()
            require "lsp_signature".setup({
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                hint_enable = false,
                handler_opts = {
                    border = "rounded"
                    -- border = "single"
                },
            })

            require 'lsp_signature'.on_attach()
        end
    },
}
