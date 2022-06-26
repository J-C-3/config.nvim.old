-- Packer

-- Init {{{
-- Don't mind me:{{{
vim = vim
--}}}

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local firstRun = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    firstRun = true
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd [[
        packadd packer.nvim
]]

--}}}

-- Plugins{{{
require('packer').startup({ function()
    local use = require('packer').use

    use 'wbthomason/packer.nvim'

    -- Modes{{{
    use {
        'sindrets/winshift.nvim'
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    use {
        'mbbill/undotree',
        opt = true
    }

    use {
        'preservim/tagbar',
        install = function()
            vim.cmd("!"..vim.fn.stdpath("config").."/scripts/ctags.sh")
        end,
        config = function()
            vim.cmd[[
            ]]
        end,
    }

    use {
        "akinsho/toggleterm.nvim",
        opt = false,
        config = function() --{{{
            require("toggleterm").setup {
                size = 15,
                hide_numbers = true,
                shade_terminals = true,
                shading_factor = '0.4',
                start_in_insert = true,
                terminal_mappings = true,
                persist_size = true,
                direction = 'horizontal',
                close_on_exit = false,
                highlights = {
                    Normal = {
                        link = "Terminal"
                    },
                    SignColumn = {
                        link = "Terminal"
                    }
                },
                shell = vim.fn.expand("~") .. "/.config/nvim/vimterm.sh",
            }
        end --}}}
    }

    use "numToStr/FTerm.nvim"

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
        config = function()
            --vim.g.gruvbox_bold = 1
            --vim.g.gruvbox_italic = 1
            --vim.g.gruvbox_transparent_bg = 1
            --vim.g.gruvbox_underline = 1
            --vim.g.gruvbox_undercurl = 1
            --vim.g.gruvbox_termcolors = 0
            --vim.g.gruvbox_contrast_dark = "medium"
            --vim.g.gruvbox_contrast_light = "medium"
            --vim.g.gruvbox_hls_cursor = "orange"
            --vim.g.gruvbox_number_column = "bg1"
            --vim.g.gruvbox_sign_column = "bg2"
            --vim.g.gruvbox_color_column = "bg2"
            --vim.g.gruvbox_vert_split = "bg0"
            --vim.g.gruvbox_italicize_comments = 1
            --vim.g.gruvbox_italicize_strings = 0
            --vim.g.gruvbox_invert_selection = 0
            --vim.g.gruvbox_invert_signs = 0
            --vim.g.gruvbox_invert_indent_guides = 0
            --vim.g.gruvbox_invert_tabline = 0
            --vim.g.gruvbox_improved_strings = 0
            --vim.g.gruvbox_improved_warnings = 0
            --vim.g.gruvbox_guisp_fallback = 'NONE'

            --vim.cmd[[highlight link TSError Normal]]
            --vim.cmd("colorscheme gruvbox")

            --vim.cmd('highlight NvimTreeNormal guibg='..Darken(Util.getColor("Normal", "bg#"), 0.8))
        end
    }
    use {
        "rebelot/kanagawa.nvim",
        config = function()
            local conf = {
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                typeStyle = {},
                variablebuiltinStyle = { italic = true },
                specialReturn = true, -- special highlight for the return keyword
                specialException = true, -- special highlight for exception handling keywords
                transparent = false, -- do not set background color
                dimInactive = false, -- dim inactive window `:h hl-NormalNC`
                globalStatus = true, -- adjust window separators highlight for laststatus=3
                colors = {},
                overrides = {},
            }

            require('kanagawa').setup(conf)

            vim.cmd("colorscheme kanagawa")

            vim.cmd('highlight NvimTreeNormal guibg=' .. Darken(Util.getColor("Normal", "bg#"), 0.6))
            vim.cmd('highlight NvimTreeNormalNC guibg=' .. Darken(Util.getColor("Normal", "bg#"), 0.6))
            vim.cmd('highlight Terminal guibg=' .. Darken(Util.getColor("Normal", "bg#"), 0.5))
        end
    }
    --}}}

    use {
        'nvim-treesitter/nvim-treesitter',
        config = function() --{{{
            local tree_cb = require 'nvim-tree.config'.nvim_tree_callback

            require 'nvim-tree'.setup {
                disable_netrw       = false,
                hijack_netrw        = false,
                open_on_setup       = false,
                ignore_ft_on_setup  = {},
                update_to_buf_dir   = {
                    enable = true,
                    auto_open = true,
                },
                open_on_tab         = false,
                hijack_cursor       = false,
                update_cwd          = false,
                update_focused_file = {
                    enable      = true,
                    update_cwd  = false,
                    ignore_list = {}
                },
                system_open         = {
                    cmd  = nil,
                    args = {}
                },
                view                = {
                    width = 30,
                    side = 'left',
                    mappings = {
                        custom_only = false,
                        list = {
                            { key = { "<2-RightMouse>", "C" }, cb = tree_cb("cd") },
                        }
                    }
                },
                actions             = {
                    open_file = {
                        resize_window = false,
                    }
                }
            }

            require 'nvim-treesitter.configs'.setup {
                ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                ignore_install = { 'haskell', 'phpdoc', 'norg' }, -- List of parsers to ignore installing
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = true,
                    -- custom_captures = {
                    --     ["variable"] = "Constant",
                },
                rainbow = {
                    enable = true,
                    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                    max_file_lines = nil, -- Do not enable for files with more than n lines, int
                    -- colors = {}, -- table of hex strings
                    -- termcolors = {} -- table of colour name strings
                },
            }
        end --}}}
    }
    use 'p00f/nvim-ts-rainbow'

    use 'kevinhwang91/nvim-hlslens'

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
        requires = 'kyazdani42/nvim-web-devicons', -- If you want devicons
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

    use {
        "folke/lua-dev.nvim",
        config = function() --{{{
            local luadev = require("lua-dev").setup({
                lspconfig = {
                    cmd = { vim.fn.stdpath('data') ..
                        "/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server" }
                },
            })

            local lspconfig = require('lspconfig')
            lspconfig.sumneko_lua.setup(luadev)
        end --}}}
    }

    -- Ansible
    use {
        'pearofducks/ansible-vim',
        opt = true,
        ft = { 'ansible' }
    }

    -- GPG
    use 'jamessan/vim-gnupg'

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
                sidebar = {
                    -- You can change the order of elements in the sidebar
                    elements = {
                        -- Provide as ID strings or tables with "id" and "size" keys
                        { id = "scopes", size = 0.50, },
                        { id = "breakpoints", size = 0.25 },
                        { id = "watches", size = 0.25 },
                    },
                    size = 40,
                    position = "left", -- Can be "left", "right", "top", "bottom"
                },
                tray = {
                    elements = { "repl" },
                    size = 10,
                    position = "bottom", -- Can be "left", "right", "top", "bottom"
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
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'

    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

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
                            cmdline  = "[CmdLine]",
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
                })
            })
        end --}}}
    }
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-look'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-calc'
    use 'hrsh7th/cmp-nvim-lua'
    use 'f3fora/cmp-spell'

    use 'hrsh7th/cmp-vsnip'
    use {
        'hrsh7th/vim-vsnip',
        config = function()
            vim.g.vsnip_snippet_dir = os.getenv('HOME') .. "/.config/nvim/vsnip/"
        end
    }
    use 'rafamadriz/friendly-snippets'

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

    use 'onsails/lspkind-nvim'

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
        'tami5/lspsaga.nvim',
        config = function() --{{{
            require('lspsaga').init_lsp_saga {
                use_saga_diagnostic_sign = true,
                error_sign = '',
                warn_sign = '',
                hint_sign = '',
                infor_sign = '',
                code_action_icon = ' ',
                code_action_prompt = {
                    enable = true,
                    sign = false,
                    sign_priority = 20,
                    virtual_text = true,
                },

                -- finder_definition_icon = '  ',
                -- finder_reference_icon = '  ',
                -- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
                -- finder_action_keys = {
                --   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
                -- },
                -- code_action_keys = {
                --   quit = 'q',exec = '<CR>'
                -- },
                -- rename_action_keys = {
                --   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
                -- },
                -- definition_preview_icon = '  '
                -- "single" "double" "round" "plus"
                border_style = "double",
                rename_prompt_prefix = '>',
                -- if you don't use nvim-lspconfig you must pass your server name and
                -- the related filetypes into this table
                -- like server_filetype_map = {metals = {'sbt', 'scala'}}
                -- server_filetype_map = {}
            }
        end --}}}
    }
    --}}}

    -- Misc/QOL {{{
    use 'powerman/vim-plugin-AnsiEsc'
    use { "LinArcX/telescope-command-palette.nvim" }

    use {
        'folke/which-key.nvim',
        config = function() --{{{
            require("which-key").setup {
                triggers_blacklist = {
                    i = { "<" },
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

    use {
        'declancm/maximize.nvim',
        config = function() --{{{
            require('maximize').setup({
                default_keymaps = false,
            })
        end --}}}
    }

    use {
        'edluffy/specs.nvim',
        config = function() --{{{
            require('specs').setup {
                show_jumps       = true,
                min_jump         = 10,
                popup            = {
                    delay_ms = 0, -- delay before popup displays
                    inc_ms = 10, -- time increments used for fade/resize effects
                    blend = 50, -- starting blend, between 0-100 (fully transparent), see :h winblend
                    width = 30,
                    winhl = "TermCursor",
                    fader = require('specs').exp_fader,
                    resizer = require('specs').slide_resizer
                },
                ignore_filetypes = {},
                ignore_buftypes  = {
                    nofile = true,
                },
            }
        end --}}}
    }

    use 'norcalli/nvim-colorizer.lua'

    use 'nvim-lua/plenary.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        config = function() --{{{
            require('telescope').setup({
                extensions = {
                    command_palette = {
                        { "File",
                            { "entire selection (C-a)", ':call feedkeys("GVgg")' },
                            { "save current file (C-s)", ':w' },
                            { "save all files (C-A-s)", ':wa' },
                            { "quit (C-q)", ':qa' },
                            { "file browser (C-i)", ":lua require'telescope'.extensions.file_browser.file_browser()",
                                1 },
                            { "search word (A-w)", ":lua require('telescope.builtin').live_grep()", 1 },
                            { "git files (A-f)", ":lua require('telescope.builtin').git_files()", 1 },
                            { "files (C-f)", ":lua require('telescope.builtin').find_files()", 1 },
                        },
                        { "Help",
                            { "tips", ":help tips" },
                            { "cheatsheet", ":help index" },
                            { "tutorial", ":help tutor" },
                            { "summary", ":help summary" },
                            { "quick reference", ":help quickref" },
                            { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 },
                        },
                        { "Vim",
                            { "reload vimrc", ":source $MYVIMRC" },
                            { 'check health', ":checkhealth" },
                            { "jumps (Alt-j)", ":lua require('telescope.builtin').jumplist()" },
                            { "commands", ":lua require('telescope.builtin').commands()" },
                            { "command history", ":lua require('telescope.builtin').command_history()" },
                            { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
                            { "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
                            { "vim options", ":lua require('telescope.builtin').vim_options()" },
                            { "keymaps", ":lua require('telescope.builtin').keymaps()" },
                            { "buffers", ":Telescope buffers" },
                            { "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
                            { "paste mode", ':set paste!' },
                            { 'cursor line', ':set cursorline!' },
                            { 'cursor column', ':set cursorcolumn!' },
                            { "spell checker", ':set spell!' },
                            { "relative number", ':set relativenumber!' },
                            { "search highlighting (F12)", ':set hlsearch!' },
                        },
                        { "Debug",
                            { "Toggle breakpoint <leader>db", ":lua require('dap').toggle_breakpoint()" },
                            { "Step into <leader>di", ":lua require('dap').step_into()" },
                            { "Step over <leader>dn", ":lua require('dap').step_over()" },
                            { "Step out <leader>do", ":lua require('dap').step_out()" },
                            { "Up <leader>du", ":lua require('dap').up()" },
                            { "Down <leader>dd", ":lua require('dap').down()" },
                            { "Run to cursor <leader>drn", ":lua require('dap').run_to_cursor()" },
                            { "Continue <leader>dc", ":lua require('dap').continue()" },
                            { "DAP Open <leader>ds", ":lua require('dapui').open()" },
                            { "DAP Stop/Close <leader>dS", ":lua Util.dapStop()" },
                        }
                    }
                }
            })

            require('telescope').load_extension('command_palette')

        end --}}}
    }

    use 'tpope/vim-commentary'

    use {
        "lukas-reineke/indent-blankline.nvim",
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function() --{{{
            require('gitsigns').setup()
        end, --}}}
    }

    use 'kazhala/close-buffers.nvim'
    -- }}}

    if packer_bootstrap then
        require('packer').sync()
    end
end,
    config = {
        max_jobs = 1,
        profile = {
            enable = true,
            threshold = 1
        }
    }
})

if firstRun then
    require('packer').sync()
end
-- }}}
