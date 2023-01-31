plugins.treesitter = {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "HiPhish/nvim-ts-rainbow2",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "windwp/nvim-ts-autotag",
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = true,
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
                    "jsonc",
                    "jsonnet",
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
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = true,
                },
                rainbow = {
                    enable = true,
                    disable = { "jsx", "cpp" },
                    query = 'rainbow-parens',
                    strategy = require 'ts-rainbow.strategy.global',
                    max_file_lines = nil,
                },
                autotag = {
                    enable = true
                },
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["aC"] = "@class.outer",
                            ["iC"] = "@class.inner",
                            ["ac"] = "@conditional.outer",
                            ["ic"] = "@conditional.inner",
                            ["ae"] = "@block.outer",
                            ["ie"] = "@block.inner",
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                            ["is"] = "@statement.inner",
                            ["as"] = "@statement.outer",
                            ["ad"] = "@comment.outer",
                            ["am"] = "@call.outer",
                            ["im"] = "@call.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = { query = "@class.outer", desc = "Next class start" },
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                },
                context_commentstring = {
                    enable = true,
                    commentary_integration = {
                        -- change default mapping
                        Commentary = false,
                        -- disable default mapping
                        CommentaryLine = false,
                    },
                },
            })
        end
    },
}
