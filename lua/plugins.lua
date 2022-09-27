-- Packer

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local firstRun = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    firstRun = true
    vim.notify("Cloning packer.nvim...")
    vim.cmd("silent !git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd [[
        packadd packer.nvim
    ]]

require('packer').startup({ function()
    local use = require('packer').use

    use {
        'wbthomason/packer.nvim'
    }

    -- only for seeing what's taking so long if we get a slowdown
    -- use {
    --     'tweekmonster/startuptime.vim'
    -- }

    -- Modes{{{
    use {
        'sindrets/winshift.nvim'
    }

    use {
        'mbbill/undotree',
        opt = true
    }

    use {
        'preservim/tagbar',
        install = function()
            vim.cmd("!" .. vim.fn.stdpath("config") .. "/scripts/ctags.sh")
        end,
        config = function()
            vim.cmd [[
            ]]
        end,
    }

    use {
        "akinsho/toggleterm.nvim",
        opt = false,
        config = function() --{{{
            require("toggleterm").setup {
                open_mapping = [[<c-`>]],
                size = 15,
                hide_numbers = true,
                shade_terminals = true,
                shading_factor = '0.4',
                start_in_insert = true,
                terminal_mappings = true,
                persist_size = true,
                direction = 'horizontal',
                close_on_exit = false,
            }
        end --}}}
    }

    use {
        'vimwiki/vimwiki',
        config = function() --{{{
            vim.g.vimwiki_key_mappings = {
                all_maps = 1,
                global = 1,
                headers = 1,
                text_objs = 1,
                table_format = 1,
                table_mappings = 0,
                lists = 1,
                links = 0,
                html = 1,
                mouse = 0,
            }
        end --}}}
    }
    --}}}

    -- Aesthetics{{{
    -- Theme{{{
    use {
        'ellisonleao/gruvbox.nvim',
    }
    use {
        "rebelot/kanagawa.nvim",
    }
    --}}}

    use {
        'nvim-treesitter/nvim-treesitter',
        config = function() --{{{
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                ignore_install = { 'haskell', 'phpdoc', 'norg' }, -- List of parsers to ignore installing
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = true,
                    -- custom_captures = {
                    --     ["variable"] = "Constant",
                },
                indent = {
                    enable = true,
                },
                rainbow = {
                    enable = false,
                    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                    max_file_lines = nil, -- Do not enable for files with more than n lines, int
                    -- colors = {}, -- table of hex strings
                    -- termcolors = {} -- table of colour name strings
                },
            }
        end --}}}
    }

    use {
        'nvim-treesitter/playground',
        after = 'nvim-treesitter'
    }

    use {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require 'treesitter-context'.setup { -- {{{
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                    -- For all filetypes
                    -- Note that setting an entry here replaces all other patterns for this entry.
                    -- By setting the 'default' entry below, you can control which nodes you want to
                    -- appear in the context window.
                    default = {
                        'class',
                        'function',
                        'method',
                        'for',
                        'while',
                        'if',
                        'switch',
                        'case',
                    },
                    -- Patterns for specific filetypes
                    -- If a pattern is missing, *open a PR* so everyone can benefit.
                    tex = {
                        'chapter',
                        'section',
                        'subsection',
                        'subsubsection',
                    },
                    rust = {
                        'impl_item',
                        'struct',
                        'enum',
                    },
                    scala = {
                        'object_definition',
                    },
                    vhdl = {
                        'process_statement',
                        'architecture_body',
                        'entity_declaration',
                    },
                    markdown = {
                        'section',
                    },
                    elixir = {
                        'anonymous_function',
                        'arguments',
                        'block',
                        'do_block',
                        'list',
                        'map',
                        'tuple',
                        'quoted_content',
                    },
                    json = {
                        'pair',
                    },
                    yaml = {
                        'block_mapping_pair',
                    },
                },
                exact_patterns = {
                    -- Example for a specific filetype with Lua patterns
                    -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
                    -- exactly match "impl_item" only)
                    -- rust = true,
                },

                -- [!] The options below are exposed but shouldn't require your attention,
                --     you can safely ignore them.

                zindex = 20, -- The Z-index of the context window
                mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
            } -- }}}
        end,
        after = 'nvim-treesitter'
    }

    use {
        'p00f/nvim-ts-rainbow',
        after = 'nvim-treesitter'
    }

    use {
        'kevinhwang91/nvim-hlslens'
    }

    use({ 'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() --{{{
            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '|', right = '|' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {},
                    always_divide_middle = true,
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                extensions = {}
            })
        end --}}}
    })

    use({ 'noib3/nvim-cokeline',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() --{{{
            local get_hex = require('cokeline/utils').get_hex

            require('cokeline').setup({
                default_hl = {
                    fg = function(buffer)
                        return buffer.is_focused
                            and get_hex('ColorColumn', 'bg')
                            or get_hex('Normal', 'fg')
                    end,
                    bg = function(buffer)
                        return buffer.is_focused
                            and get_hex('Normal', 'fg')
                            or get_hex('ColorColumn', 'bg')
                    end,
                },

                sidebar = {
                    filetype = 'NvimTree',
                    components = {
                        {
                            text = '  NvimTree',
                            fg = get_hex('Normal', 'fg'),
                            bg = get_hex('Normal', 'bg'),
                            style = 'bold',
                        },
                    }
                },

                components = {
                    {
                        text = function(buffer)
                            return (buffer.index ~= 1) and '▏' or ''
                        end,
                    },
                    {
                        text = '  ',
                    },
                    {
                        text = function(buffer)
                            return buffer.devicon.icon
                        end,
                        fg = function(buffer)
                            return buffer.devicon.color
                        end,
                    },
                    {
                        text = ' ',
                    },
                    {
                        text = function(buffer)
                            return buffer.unique_prefix .. buffer.filename .. '  '
                        end,
                        style = function(buffer)
                            return buffer.is_focused and 'bold' or nil
                        end,
                    },
                    {
                        text = function(buffer)
                            return buffer.is_modified and "●" or ""
                        end,
                        delete_buffer_on_left_click = true,
                    },
                    {
                        text = '  ',
                    },
                },
            })
        end --}}}
    })
    --}}}

    -- Languages/Filetypes {{{
    use "nathom/filetype.nvim"

    -- Ansible
    use {
        'pearofducks/ansible-vim',
        opt = true,
        ft = { 'ansible' }
    }

    -- GPG
    use {
        'jamessan/vim-gnupg'
    }

    -- C
    use {
        'rhysd/vim-clang-format',
        opt = true,
        ft = { 'c', 'cpp' }
    }

    -- CSV
    use {
        'chrisbra/csv.vim',
        opt = true,
        ft = { 'csv' }
    }

    -- Python
    use {
        'davidhalter/jedi-vim',
        opt = true,
        ft = { 'python' },
        config = function() --{{{
            vim.cmd [[ let g:jedi#use_tabs_not_buffers = 0 ]]
            vim.cmd [[ let g:jedi#use_splits_not_buffers = 1 ]]
            vim.cmd [[ let g:jedi#auto_initialization = 1 ]]
            vim.cmd [[ let g:jedi#auto_vim_configuration = 1 ]]
            vim.cmd [[ let g:jedi#goto_command = "" ]]
            vim.cmd [[ let g:jedi#goto_assignments_command = "" ]]
            vim.cmd [[ let g:jedi#goto_definitions_command = "" ]]
            vim.cmd [[ let g:jedi#goto_stubs_command = "" ]]
            vim.cmd [[ let g:jedi#completions_command = "" ]]
            vim.cmd [[ let g:jedi#call_signatures_command = "" ]]
            vim.cmd [[ let g:jedi#usages_command = "" ]]
            vim.cmd [[ let g:jedi#rename_command = "" ]]
            vim.cmd [[ let g:jedi#completions_enabled = 1 ]]
            vim.cmd [[ let g:jedi#popup_on_dot = 0 ]]
            vim.cmd [[ let g:jedi#documentation_command = "" ]]
            vim.cmd [[ let g:jedi#show_call_signatures_delay = 500 ]]
            vim.cmd [[ let g:jedi#call_signature_escape = "?!?" ]]
            vim.cmd [[ let g:jedi#auto_close_doc = 1 ]]
            vim.cmd [[ let g:jedi#max_doc_height = 30 ]]
            vim.cmd [[ let g:jedi#popup_select_first = 1 ]]
            vim.cmd [[ let g:jedi#quickfix_window_height = 10 ]]
            vim.cmd [[ let g:jedi#force_py_version = "auto" ]]
            vim.cmd [[ let g:jedi#environment_path = "auto" ]]
            vim.cmd [[ let g:jedi#added_sys_path = "[]" ]]
            vim.cmd [[ let g:jedi#project_path = "auto" ]]
            vim.cmd [[ let g:jedi#smart_auto_mappings = 0 ]]
            vim.cmd [[ let g:jedi#use_tag_stack = 1 ]]
        end --}}}
    }

    use {
        'raimon49/requirements.txt.vim',
        opt = true,
        ft = { 'txt' }
    }

    use {
        'mfussenegger/nvim-dap-python',
        opt = true,
        ft = { 'python' }
    }

    use {
        'psf/black',
        opt = true,
        ft = { 'python' }
    }

    -- Go
    use {
        'fatih/vim-go',
        opt = true,
        ft = { 'go', 'gomod' },
        config = function() --{{{
            vim.g.go_template_use_pkg = 1
            vim.g.go_highlight_array_whitespace_error = 0
            vim.g.go_highlight_build_constraints = 0
            vim.g.go_highlight_diagnostic_errors = 0
            vim.g.go_highlight_extra_types = 0
            vim.g.go_highlight_fields = 0
            vim.g.go_highlight_format_strings = 0
            vim.g.go_highlight_functions = 0
            vim.g.go_highlight_function_calls = 0
            vim.g.go_highlight_function_parameters = 0
            vim.g.go_highlight_generate_tags = 0
            vim.g.go_highlight_methods = 0
            vim.g.go_highlight_operators = 0
            vim.g.go_highlight_space_tab_error = 0
            vim.g.go_highlight_structs = 0
            vim.g.go_highlight_trailing_whitespace_error = 0
            vim.g.go_highlight_types = 0
            vim.g.go_highlight_variable_declarations = 0
            vim.g.go_highlight_variable_assignments = 0
            vim.g.go_auto_sameids = 0
            vim.g.go_def_mapping_enabled = 0
            vim.g.go_list_type = "quickfix"
            vim.g.go_fmt_autosave = 1
            vim.g.go_imports_autosave = 1
            vim.g.go_fmt_command = "goimports"
            vim.g.go_fmt_fail_silently = 0
            vim.g.go_rename_command = "gopls"
        end, --}}}
    }

    -- Rust
    use {
        'rust-lang/rust.vim',
        opt = true,
        ft = { 'rust' }
    }

    -- Openscad (kinda)
    use {
        'sirtaj/vim-openscad',
        opt = true,
        ft = { 'openscad' }
    }

    -- markdown
    use {
        'plasticboy/vim-markdown',
        requires = 'godlygeek/tabular',
        opt = true,
        ft = { 'markdown' },
        config = function() --{{{
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_no_default_key_mappings = 1
            vim.g.vim_markdown_conceal = 1
            vim.g.vim_markdown_conceal_code_blocks = 0
            vim.g.vim_markdown_strikethrough = 1

            vim.o.conceallevel = 2
        end, --}}}
    }

    -- -- hare
    -- use {
    --     'https://git.sr.ht/~sircmpwn/hare.vim',
    -- }
    -- }}}

    -- LSP & Completion {{{
    use {
        'mfussenegger/nvim-dap',
        config = function() --{{{
            local dap = require('dap')

            dap.adapters.go = function(callback, config)
                local handle
                local port = 38697
                handle, _ = vim.loop.spawn("dlv", {
                    args = { "dap", "-l", "127.0.0.1:" .. port },
                    detached = true
                }, function(code)
                    handle:close()
                    print("Delve exited with exit code: " .. code)
                end)
                -- Wait 100ms for delve to start
                vim.defer_fn(function()
                    dap.repl.open()
                    callback({ type = "server", host = "127.0.0.1", port = port })
                end, 100)
            end

            -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
            require("dapui").setup({
                icons = { expanded = "▾", collapsed = "▸" },
                mappings = {
                    -- Use a table to apply multiple mappings
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                },
                layouts = {
                    {
                        elements = {
                            'scopes',
                            'breakpoints',
                            'stacks',
                            'watches',
                        },
                        size = 40,
                        position = 'left',
                    },
                    {
                        elements = {
                            'repl',
                            'console',
                        },
                        size = 10,
                        position = 'bottom',
                    },
                },
                floating = {
                    max_height = nil, -- These can be integers or a float between 0 and 1.
                    max_width = nil, -- Floats will be treated as percentage of your screen.
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
            })

            dap.adapters.dlv_spawn = function(cb)
                local stdout = vim.loop.new_pipe(false)
                local handle
                local pid_or_err
                local port = 38697
                local opts = {
                    stdio = { nil, stdout },
                    args = { "dap", "-l", "127.0.0.1:" .. port },
                    detached = true
                }
                handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
                    stdout:close()
                    handle:close()
                    if code ~= 0 then
                        print('dlv exited with code', code)
                    end
                end)
                assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
                stdout:read_start(function(err, chunk)
                    assert(not err, err)
                    if chunk then
                        vim.schedule(function()
                            --- You could adapt this and send `chunk` to somewhere else
                            require('dap.repl').append(chunk)
                        end)
                    end
                end)
                -- Wait for delve to start
                vim.defer_fn(
                    function()
                        cb({ type = "server", host = "127.0.0.1", port = port })
                    end,
                    100)
            end

            dap.configurations.go = {
                {
                    type = 'dlv_spawn',
                    name = 'Launch dlv & file',
                    request = 'launch',
                    program = "${workspaceFolder}";
                },
                {
                    type = "go",
                    name = "Debug",
                    request = "launch",
                    program = "${workspaceFolder}"
                },
                {
                    type = "dlv_spawn",
                    name = "Debug with arguments",
                    request = "launch",
                    program = "${workspaceFolder}",
                    args = function()
                        local args_string = vim.fn.input('Arguments: ')
                        return vim.split(args_string, " +")
                    end,

                },
                {
                    type = "go",
                    name = "Debug test",
                    request = "launch",
                    mode = "test", -- Mode is important
                    program = "${file}"
                }
            }

            dap.defaults.fallback.force_external_terminal = true
            dap.defaults.fallback.external_terminal = {
                command = '/Applications/Alacritty.app/Contents/MacOS/alacritty';
                args = { '-e' };
            }
            require('nvim-dap-virtual-text').setup()
        end --}}}
    }
    use {
        'rcarriga/nvim-dap-ui'
    }
    use {
        'theHamsta/nvim-dap-virtual-text'
    }

    use {
        "williamboman/mason.nvim",
    }

    use {
        "williamboman/mason-lspconfig.nvim",
    }

    use {
        "neovim/nvim-lspconfig"
    }

    use {
        'hrsh7th/nvim-cmp',
        config = function() --{{{
            local cmp = require 'cmp'

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local feedkey = function(key, mode)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end

            -- cmp.register_source('look', require('cmp_look').new())
            --

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    end
                },
                formatting = {
                    format = require('lspkind').cmp_format({
                        with_text = true,
                        maxwidth  = 50,
                        menu      = ({
                            buffer   = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            vsnip    = "[Vsnip]",
                            nvim_lua = "[Lua]",
                            look     = "[Look]",
                            spell    = "[Spell]",
                            path     = "[Path]",
                            calc     = "[Calc]",
                        })
                    })
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.fn["vsnip#available"]() == 1 then
                            feedkey("<Plug>(vsnip-expand-or-jump)", "")
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                            feedkey("<Plug>(vsnip-jump-prev)", "")
                        end
                    end, { "i", "s" }),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                },
                preselect = cmp.PreselectMode.None,
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'vsnip' },
                    { name = 'buffer' },
                    { name = 'look', keyword_length = 2, options = { convert_case = true, loud = true } },
                    { name = 'spell' },
                    { name = 'cmdline' },
                    { name = 'path' },
                    { name = 'calc' },
                    { name = "dictionary" },
                })
            })
        end --}}}
    }

    use {
        'hrsh7th/cmp-nvim-lsp',
        after = 'nvim-cmp'
    }

    use {
        'hrsh7th/cmp-buffer',
        after = 'nvim-cmp'
    }

    use {
        'hrsh7th/cmp-look',
        after = 'nvim-cmp'
    }

    use {
        'hrsh7th/cmp-path',
        after = 'nvim-cmp'
    }

    use {
        'hrsh7th/cmp-calc',
        after = 'nvim-cmp'
    }

    use {
        'hrsh7th/cmp-nvim-lua',
        after = 'nvim-cmp'
    }

    use {
        'f3fora/cmp-spell',
        after = 'nvim-cmp'
    }

    use {
        'uga-rosa/cmp-dictionary',
        after = 'nvim-cmp'
    }

    use {
        'hrsh7th/cmp-vsnip',
        after = 'nvim-cmp'
    }
    use {
        'hrsh7th/vim-vsnip',
        config = function()
            vim.g.vsnip_snippet_dir = os.getenv('HOME') .. "/.config/nvim/vsnip/"
        end
    }

    use {
        'rafamadriz/friendly-snippets'
    }

    use {
        'ray-x/lsp_signature.nvim',
        config = function() --{{{
            require "lsp_signature".setup({
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                hint_enable = false,
                handler_opts = {
                    border = "single"
                },
            })

            require 'lsp_signature'.on_attach()
        end --}}}
    }

    use {
        'onsails/lspkind-nvim'
    }

    use {
        'windwp/nvim-autopairs',
        config = function() --{{{
            require('nvim-autopairs').setup({
                disable_filetype = { "TelescopePrompt", "vim" },
                disable_in_macro = true,
                ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
                enable_moveright = true,
                enable_afterquote = true, -- add bracket pairs after quote,
                enable_check_bracket_line = true, --- check bracket in same line,
                map_bs = true, -- map the <BS> key,
                map_c_w = false, -- map <c-w> to delete an pair if possible,
                check_ts = true,
                ts_config = {
                    lua = { 'string' }, -- it will not add a pair on that treesitter node
                    javascript = { 'template_string' },
                    java = false, -- don't check treesitter on java
                }
            })

            -- require('nvim-autopairs.ts-conds').add_rules({
            --     Rule("%", "%", "lua")
            --         :with_pair(ts_conds.is_ts_node({'string','comment'})),
            --     Rule("$", "$", "lua")
            --         :with_pair(ts_conds.is_not_ts_node({'function'}))
            -- })

            -- require("nvim-autopairs.completion.cmp").setup({
            --     map_cr = true,
            --     map_complete = true,
            --     auto_select = true,
            --     insert = false,
            --     map_char = {
            --         all = '(',
            --         tex = '{'
            --     }
            -- })
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
        end --}}}
    }

    use {
        'glepnir/lspsaga.nvim',
        config = function() --{{{
            local saga = require 'lspsaga'

            -- change the lsp symbol kind
            -- local kind = require('lspsaga.lspkind')
            -- -- kind[type_number][2] = icon -- see lua/lspsaga/lspkind.lua

            -- use custom config
            saga.init_lsp_saga({
                -- put modified options in there
                -- Options with default value
                -- "single" | "double" | "rounded" | "bold" | "plus"
                border_style = "single",
                --the range of 0 for fully opaque window (disabled) to 100 for fully
                --transparent background. Values between 0-30 are typically most useful.
                saga_winblend = 0,
                -- when cursor in saga window you config these to move
                move_in_saga = { prev = '<C-p>', next = '<C-n>' },

                -- Error, Warn, Info, Hint
                diagnostic_header = { "", "", "", "" },

                -- preview lines of lsp_finder and definition preview
                max_preview_lines = 10,

                -- use emoji lightbulb in default
                code_action_icon = ' ',

                -- if true can press number to execute the codeaction in codeaction window
                code_action_num_shortcut = true,

                -- same as nvim-lightbulb but async
                code_action_lightbulb = {
                    enable = true,
                    sign = true,
                    sign_priority = 20,
                    virtual_text = true,
                },

                -- finder icons
                finder_icons = {
                    def = '  ',
                    ref = '諭 ',
                    link = '  ',
                },

                finder_action_keys = {
                    open = "<CR>",
                    vsplit = "s",
                    split = "i",
                    quit = "<ESC>",
                    scroll_down = "<C-f>",
                    scroll_up = "<C-b>", -- quit can be a table
                },

                code_action_keys = {
                    quit = "<ESC>",
                    exec = "<CR>",
                },

                rename_action_quit = "<ESC>",

                -- show symbols in winbar must nightly
                symbol_in_winbar = {
                    in_custom = true,
                    enable = true,
                    separator = ' ',
                    show_file = true,
                    click_support = false,
                },

                -- show outline
                show_outline = {
                    win_position = 'right',
                    -- set the special filetype in there which in left like nvimtree neotree defx
                    left_with = 'nvimtree',
                    win_width = 30,
                    auto_enter = true,
                    auto_preview = true,
                    virt_text = '┃',
                    jump_key = '<CR>',
                    -- auto refresh when change buffer
                    auto_refresh = true,
                },
                -- if you don't use nvim-lspconfig you must pass your server name and
                -- the related filetypes into this table
                -- like server_filetype_map = { metals = { "sbt", "scala" } }
                server_filetype_map = {},
            })
        end
    }
    --}}}

    -- }}}

    -- Misc/QOL {{{
    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" }
        },
        config = function()
            require('refactoring').setup({
                -- prompt for return type
                prompt_func_return_type = {
                    go = true,
                    cpp = true,
                    c = true,
                    java = true,
                },
                -- prompt for function parameters
                prompt_func_param_type = {
                    go = true,
                    cpp = true,
                    c = true,
                    java = true,
                },
            })
        end
    }

    use {
        'powerman/vim-plugin-AnsiEsc'
    }

    use {
        'folke/which-key.nvim',
        config = function() --{{{
            require("which-key").setup {
                triggers_blacklist = {
                    c = { "h" },
                }
            }
        end --}}}
    }

    use({
        "aserowy/tmux.nvim", -- only used for window resize function
        config = function() --{{{
            require("tmux").setup({
                copy_sync = {
                    enable = false,
                },
                navigation = {
                    enable_default_keybindings = false,
                },
                resize = {
                    enable_default_keybindings = false,
                }
            })
        end --}}}
    })

    -- Keeps buffer proportions on window resizes and whatnot
    use {
        "kwkarlwang/bufresize.nvim",
        config = function()
            require("bufresize").setup()
        end
    }

    use {
        'norcalli/nvim-colorizer.lua'
    }

    use {
        'nvim-lua/plenary.nvim'
    }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
    }

    use {
        'nvim-telescope/telescope-ui-select.nvim'
    }

    use {
        'nvim-telescope/telescope-dap.nvim'
    }

    use {
        'nvim-telescope/telescope.nvim',
        config = function() --{{{
            require('telescope').setup({
                -- extensions = {
                -- }
            })

            require('telescope').load_extension('file_browser')
            require('telescope').load_extension('dap')
        end --}}}
    }

    use {
        'tpope/vim-commentary'
    }

    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            }
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function() --{{{
            require('gitsigns').setup()
        end, --}}}
    }
    -- }}}

    local userPlugins = vim.api.nvim_get_runtime_file("*/user.d/*plugins.lua", true)

    for _, s in ipairs(userPlugins) do
        dofile(s)
    end
end,
    config = {
        max_jobs = 5,
        profile = {
            enable = true,
            threshold = 1
        },

        compile_on_sync = true,
        ensure_dependencies = true,
        compile_path = vim.fn.stdpath("data") .. "/packer/plugin/packer_compiled.lua"
    },
})

return firstRun
