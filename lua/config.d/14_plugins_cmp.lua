plugins.cmp = {
    {
        "hrsh7th/nvim-cmp",
        opts = function()
            local cmp = require("cmp")
            cmp.setup({
                sources = {
                    {
                        name = "buffer"
                    },
                    {
                        name = "calc"
                    },
                    {
                        name = "cmdline"
                    },
                    {
                        name = "dictionary",
                    },
                    {
                        name = "look",
                        keyword_length = 2,
                        option = {
                            convert_case = true,
                            loud = true,
                        }
                    },
                    {
                        name = 'luasnip'
                    },
                    {
                        name = "nvim_lsp"
                    },
                    {
                        name = "path"
                    },
                    {
                        name = "spell",
                        option = {
                            keep_all_entries = false,
                            enable_in_context = function()
                                return require("cmp.config.context").in_treesitter_capture('spell')
                            end,
                        },
                    },
                },
                snippet = {
                    expand = function(args)
                        require 'luasnip'.lsp_expand(args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                })
            })
        end,
    },
    {
        "hrsh7th/cmp-nvim-lua",
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        --        init = function()
        --            local lsp_config = require("lspconfig")
        --            lsp_config.util.default_config = vim.tbl_deep_extend(
        --            "force",
        --            lsp_config.util.default_config, {
        --                capabilities = require("cmp_nvim_lsp").default_capabilities(),
        --            })
        --        end,
    },
    {
        "hrsh7th/cmp-buffer",
        config = function()
            local cmp=require("cmp")
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })
        end,
    },
    {
        "hrsh7th/cmp-cmdline",
        init = function()
            local cmp=require("cmp")
            cmp.setup.cmdline({ ":" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "cmdline" }
                }
            })
        end,
    },
    {
        "hrsh7th/cmp-calc",
    },
    {
        "hrsh7th/cmp-path",
    },
    {
        "hrsh7th/cmp-look",
    },
    {
        "f3fora/cmp-spell",
    },
    {
        "uga-rosa/cmp-dictionary",
    },
    {
        "rafamadriz/friendly-snippets",
    },
    {
        "honza/vim-snippets",
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        init = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end
    },
    {
        "saadparwaiz1/cmp_luasnip",
    },
}
