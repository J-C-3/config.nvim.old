-- Nvim config

-- Reminder:
-- zo - open fold
-- zc - close fold
-- zR - open all folds
-- zM - close all folds

-- Packer {{{

-- Init {{{
-- Don't mind me:{{{
vim = vim
--}}}

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

require("packer").config = {
    max_jobs = 1,
    profile = {
        enable = true,
        threshold = 1
    }
}
--}}}

-- Plugins{{{
require('packer').startup(function()
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
        "akinsho/toggleterm.nvim",
        opt = false,
        config = function()
            require("toggleterm").setup {
                size = 20,
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
        end

    }

    use "numToStr/FTerm.nvim"

    use 'vimwiki/vimwiki'
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
                commentStyle = "italic",
                functionStyle = "NONE",
                keywordStyle = "italic",
                statementStyle = "bold",
                typeStyle = "NONE",
                variablebuiltinStyle = "italic",
                specialReturn = true, -- special highlight for the return keyword
                specialException = true, -- special highlight for exception handling keywords
                transparent = false, -- do not set background color
                dimInactive = false, -- dim inactive window `:h hl-NormalNC`
                globalStatus = true, -- adjust window separators highlight for laststatus=3
            }

            require('kanagawa').setup(conf)

            vim.cmd("colorscheme kanagawa")

            vim.cmd('highlight NvimTreeNormal guibg=' .. Darken(Util.getColor("Normal", "bg#"), 0.6))
            vim.cmd('highlight NvimTreeNormalNC guibg=' .. Darken(Util.getColor("Normal", "bg#"), 0.6))
            vim.cmd('highlight Terminal guibg=' .. Darken(Util.getColor("Normal", "bg#"), 0.5))
        end
    }
    --}}}

    use 'nvim-treesitter/nvim-treesitter'
    use 'p00f/nvim-ts-rainbow'

    use 'kevinhwang91/nvim-hlslens'

    use({ 'nvim-lualine/lualine.nvim', --{{{
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
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
        end
    }) --}}}

    use({ 'noib3/nvim-cokeline', --{{{
        requires = 'kyazdani42/nvim-web-devicons', -- If you want devicons
        config = function()
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
        end
    }) --}}}
    --}}}

    -- Languages/Filetypes {{{
    use "nathom/filetype.nvim"

    use "folke/lua-dev.nvim"

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
        ft = { 'python' }
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
        config = function()
            vim.g.go_template_use_pkg = 1
            vim.g.go_highlight_build_constraints = 1
            vim.g.go_highlight_extra_types = 1
            vim.g.go_highlight_fields = 1
            vim.g.go_highlight_functions = 1
            vim.g.go_highlight_methods = 1
            vim.g.go_highlight_operators = 1
            vim.g.go_highlight_structs = 1
            vim.g.go_highlight_types = 1
            vim.g.go_highlight_function_parameters = 1
            vim.g.go_highlight_function_calls = 1
            vim.g.go_highlight_generate_tags = 1
            vim.g.go_highlight_format_strings = 1
            vim.g.go_highlight_variable_declarations = 1
            vim.g.go_highlight_variable_assignments = 1
            vim.g.go_auto_sameids = 1
            vim.g.go_def_mapping_enabled = 0
            vim.g.go_list_type = "quickfix"
            vim.g.go_fmt_autosave = 1
            vim.g.go_imports_autosave = 1
            vim.g.go_fmt_command = "goimports"
            vim.g.go_fmt_fail_silently = 0
            vim.g.go_highlight_types = 1
            vim.g.go_highlight_diagnostic_errors = 1
            vim.g.go_highlight_fields = 1
            vim.g.go_highlight_functions = 1
            vim.g.go_highlight_methods = 1
            vim.g.go_highlight_operators = 1
            vim.g.go_highlight_build_constraints = 1
            vim.g.go_highlight_structs = 1
            vim.g.go_highlight_generate_tags = 1
            vim.g.go_highlight_space_tab_error = 0
            vim.g.go_highlight_array_whitespace_error = 0
            vim.g.go_highlight_trailing_whitespace_error = 0
            vim.g.go_highlight_extra_types = 1
            vim.g.go_rename_command = "gopls"
        end,
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
        ft = { 'markdown' }
    }
    -- }}}

    -- LSP & Completion {{{
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'

    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-look'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-calc'
    use 'hrsh7th/cmp-nvim-lua'
    use 'f3fora/cmp-spell'

    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'rafamadriz/friendly-snippets'

    use 'ray-x/lsp_signature.nvim'

    use 'onsails/lspkind-nvim'

    use 'windwp/nvim-autopairs'

    use 'tami5/lspsaga.nvim'
    --}}}

    -- Misc/QOL {{{
    use 'powerman/vim-plugin-AnsiEsc'
    use { "LinArcX/telescope-command-palette.nvim" }

    use 'folke/which-key.nvim'

    use({
        "aserowy/tmux.nvim", -- only used for window resize function
        config = function()
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
        end
    })

    use {
        'declancm/maximize.nvim',
        config = function()
            require('maximize').setup({
                default_keymaps = false,
            })
        end
    }

    use 'edluffy/specs.nvim'

    use 'norcalli/nvim-colorizer.lua'

    use 'nvim-lua/plenary.nvim'

    use {
        'junegunn/fzf',
        opt = true
    }
    use {
        'junegunn/fzf.vim',
        opt = true
    }

    use 'nvim-telescope/telescope.nvim'

    use 'tpope/vim-commentary'

    use "lukas-reineke/indent-blankline.nvim"

    use 'lewis6991/gitsigns.nvim'

    use 'kazhala/close-buffers.nvim'
    -- }}}

    if packer_bootstrap then
        require('packer').sync()
    end
end)
-- }}}

-- }}}

-- Global sets {{{
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.autoread = true
vim.backspace = { "indent", "eol", "start" }
vim.o.breakindent = true
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 1
vim.wo.colorcolumn = "80"
vim.o.cursorline = true
vim.o.encoding = "utf-8"
vim.o.expandtab = true
vim.o.fileformats = "unix,dos,mac"
vim.cmd [[filetype plugin indent on]]
vim.o.fillchars = "vert:│,fold:-,eob: "
vim.o.foldmethod = "marker"
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.inccommand = "nosplit"
vim.o.incsearch = true
vim.opt.laststatus = 3
vim.o.linebreak = true
vim.o.modeline = true
vim.o.modelines = 5
vim.o.mouse = "a"
vim.o.number = true
vim.o.numberwidth = 5
vim.o.pumblend = 15
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.scrolloff = 2
vim.o.shell = "/usr/bin/env bash"
local vimterm = vim.fn.expand("~") .. "/.config/nvim/vimterm.sh"
vim.o.shiftwidth = 4
vim.o.showbreak = "↪ "
vim.o.showmode = false
vim.o.showtabline = 2
vim.o.signcolumn = "yes:2"
vim.o.smartcase = true
vim.o.softtabstop = 0
vim.opt.spell = false
vim.opt.spelllang = { 'en_us' }
vim.o.startofline = 0
vim.o.syntax = "on"
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.timeoutlen = 250
vim.o.updatetime = 250
vim.o.wildignore = "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__"
vim.o.wildmode = "list:longest,list:full"
vim.o.wrap = true

vim.opt.fillchars:append({
    horiz = '█',
    horizup = '█',
    horizdown = '█',
    vert = '█',
    vertleft = '█',
    vertright = '█',
    verthoriz = '█',
})

vim.cmd [[set sessionoptions-=blank]]

vim.o.swapfile = false
vim.o.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.o.undofile = true

vim.o.splitright = true
vim.o.splitbelow = true

-- Remove cursorline in insert mode
vim.cmd [[autocmd InsertLeave,WinEnter * set cursorline]]
vim.cmd [[autocmd InsertEnter,WinLeave * set nocursorline]]

-- Cursor shape:
-- Insert - line; Normal - block; Replace - underline
-- Works with tmux as well
vim.cmd [[
    if empty($TMUX)
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
        let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    else
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
        let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    endif
]]

-- Neovide
vim.cmd [[set guifont=FiraCode\ Nerd\ Font\ Mono:h16]]
vim.cmd [[set guicursor+=a:blinkon650]]

-- netrw Sexplore or Lexplore
vim.cmd [[let g:netrw_winsize = 20]]

--}}}

-- Util {{{
Util = {}

Util.newTerm = function()
    if vim.fn.winnr('$') > 1 then
        vim.cmd("split term://" .. vimterm)
        return
    else
        vim.cmd("vsplit term://" .. vimterm)
        return
    end
end

Util.line_return = function()
    local line = vim.fn.line

    if line("'\"") > 0 and line("'\"") <= line("$") then
        vim.cmd("normal! g`\"zvzz'")
    end
end

-- Skips over quickfix buf when tabbing through buffers
Util.skipQF = function(dir)
    if dir == "prev" then vim.cmd [[bp]]
    else
        vim.cmd [[bn]]
    end

    while vim.api.nvim_buf_get_option(0, "buftype") == "quickfix" do
        if dir == "prev" then
            vim.cmd [[bp]]

            -- I have no idea why this is needed
            vim.cmd [[stopinsert]]
        else
            vim.cmd [[bn]]

            vim.cmd [[stopinsert]]
        end
    end
end

-- Useful for determining highlight names
vim.cmd [[
function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
]]

-- Split = function(cmd)
--     if vim.g.is_zoomed == true then
--         vim.notify("Currently zoomed")
--     else
--         vim.cmd(cmd)
--     end
-- end

-- Util.zoom = function()
--     if vim.g.is_zoomed == true then
--         vim.cmd [[tabclose]]
--         vim.g.is_zoomed = false
--     else
--         vim.cmd [[tabnew %]]
--         vim.g.is_zoomed = true
--     end
-- end

Util.dapStop = function()
    local dap = require('dap')
    local dapui = require('dapui')

    if dap.session() then
        dap.disconnect()
    end

    dap.close()
    dapui.close()
end

Util.nvimTreeToggle = function()
    vim.g.nvimtreeOpen = not vim.g.nvimtreeOpen

    require 'nvim-tree'.toggle()
end

Util.vistaToggle = function()
    vim.g.vistaOpen = not vim.g.vistaOpen

    vim.cmd [[Vista!!]]
end

Util.toggleTerm = function()
    local doWinCmd = false

    local nvimTree = require "nvim-tree"
    local nvimTreeView = require "nvim-tree.view"

    if vim.g.nvimtreeOpen then
        nvimTreeView.close()
    end

    if vim.g.vistaOpen then
        vim.cmd [[Vista!]]
    end

    vim.cmd [[ToggleTerm]]

    if vim.g.nvimtreeOpen then
        doWinCmd = true
        nvimTree.toggle()
    end

    if vim.g.vistaOpen then
        doWinCmd = true
        vim.cmd [[Vista]]
    end

    if doWinCmd then
        vim.cmd [[silent wincmd p]]
    end
end

local utilbg = "#000000"
local utilfg = "#ffffff"

local function hexToRgb(hex_str)
    local hex = "[abcdef0-9][abcdef0-9]"
    local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
    hex_str = string.lower(hex_str)

    assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

    local r, g, b = string.match(hex_str, pat)
    return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

local function blend(fg, bg, alpha)
    bg = hexToRgb(bg)
    fg = hexToRgb(fg)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

function Darken(hex, amount)
    return blend(hex, utilbg, math.abs(amount))
end

function Lighten(hex, amount)
    return blend(hex, utilfg, math.abs(amount))
end

Util.getColor = function(group, attr)
    return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end

function LazygitFloat()
    local cfg = {
        ft = 'lazygit',
        cmd = vimterm .. " lazygit",
        auto_close = false,
        dimensions = {
            height = 0.9, -- Height of the terminal window
            width = 0.9, -- Width of the terminal window
        },
    }

    local term = require('FTerm'):new(cfg)

    term:open()
end

-- }}}

-- Plugin configs {{{

-- gitsigns {{{
require('gitsigns').setup()
-- }}}

-- indent_blankline{{{
-- vim.g.indent_blankline_char_highlight = {"Comment"}
-- vim.g.indent_blankline_space_char_highlight_list = {"Comment"}

vim.g.indent_blankline_context_patterns = {
    '^if',
    '^for',
    '^class',
    '^function',
    '^method',
    '^var',
    '^struct',
    '^object',
    '^table',
    '^block',
    '^arguments',
    '^while',
    '^operand',
    '^element'
}

require("indent_blankline").setup {
    char = "▏",
    filetype_exclude = { "help", "terminal", "startify", "packer", "markdown" },
    buftype_exclude = { "terminal" },
    use_treesitter = true,
    show_current_context = true,
    show_trailing_blankline_indent = false,
    show_current_context_start = true,
    show_first_indent_level = true,
    context_highlight_list = {
        "rainbowcol1",
        "rainbowcol2",
        "rainbowcol3",
        "rainbowcol4",
        "rainbowcol5",
        "rainbowcol6",
        "rainbowcol7",
    },
    -- char_highlight_list = {
    --     "rainbowcol1",
    --     "rainbowcol2",
    --     "rainbowcol3",
    --     "rainbowcol4",
    --     "rainbowcol5",
    --     "rainbowcol6",
    --     "rainbowcol7",
    -- },
}
--}}}

-- jedi-vim {{{
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
-- }}}

-- lspsaga {{{
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
-- }}}

-- lsp_signature {{{
require "lsp_signature".setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    hint_enable = false,
    handler_opts = {
        border = "single"
    },
})

require 'lsp_signature'.on_attach()
--
-- }}}

-- lspkind {{{
-- require('lspkind').init({
--     -- enables text annotations
--     --
--     -- default: true
--     with_text = true,
--
--     -- default symbol map
--     -- can be either 'default' (requires nerd-fonts font) or
--     -- 'codicons' for codicon preset (requires vscode-codicons font)
--     --
--     -- default: 'default'
--     preset = 'codicons',
--
--     -- override preset symbols
--     --
--     -- default: {}
--     symbol_map = {
--       Text = "",
--       Method = "",
--       Function = "",
--       Constructor = "",
--       Field = "ﰠ",
--       Variable = "",
--       Class = "ﴯ",
--       Interface = "",
--       Module = "",
--       Property = "ﰠ",
--       Unit = "塞",
--       Value = "",
--       Enum = "",
--       Keyword = "",
--       Snippet = "",
--       Color = "",
--       File = "",
--       Reference = "",
--       Folder = "",
--       EnumMember = "",
--       Constant = "",
--       Struct = "פּ",
--       Event = "",
--       Operator = "",
--       TypeParameter = ""
--     },
-- })

-- }}}

-- lua-dev.nvim {{{
local luadev = require("lua-dev").setup({
    lspconfig = {
        cmd = { vim.fn.stdpath('data') .. "/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server" }
    },
})

local lspconfig = require('lspconfig')
lspconfig.sumneko_lua.setup(luadev)
-- }}}

-- nvim-autopairs {{{
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
-- }}}

-- nvim-cmp {{{
local cmp = require 'cmp'

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
-- }}}

-- nvim-dap {{{
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
-- }}}

-- nvim-notify{{{
-- vim.notify = require("notify")
-- require("notify").setup({
--   -- Animation style (see below for details)
--   stages = "slide",

--   -- Default timeout for notifications
--   timeout = 5000,

--   -- For stages that change opacity this is treated as the highlight behind the window
--   -- background_colour = "Comment",

--   -- Icons for the different levels
--   icons = {
--     ERROR = "",
--     WARN = "",
--     INFO = "",
--     DEBUG = "",
--     TRACE = "✎",
--   },
-- })
--}}}

-- nvim-scrollbar {{{
-- local themeColors = require("gruvbox.colors")
-- require("scrollbar").setup({
--     show = true,
--     handle = {
--         text = " ",
--         color = themeColors.dark4,
--         hide_if_all_visible = true, -- Hides handle if all lines are visible
--     },
--     marks = {
--         Search = { text = { "-", "=" }, priority = 0, color = themeColors.bright_orange },
--         Error = { text = { "-", "=" }, priority = 1, color = themeColors.bright_red },
--         Warn = { text = { "-", "=" }, priority = 2, color =  themeColors.bright_yellow },
--         Info = { text = { "-", "=" }, priority = 3, color =  themeColors.bright_blue },
--         Hint = { text = { "-", "=" }, priority = 4, color =  themeColors.bright_green },
--         Misc = { text = { "-", "=" }, priority = 5, color =  themeColors.bright_purple },
--     },
--     excluded_filetypes = {
--         "prompt",
--         "TelescopePrompt",
--     },
--     excluded_buftypes = {
--         "terminal"
--     },
--     autocmd = {
--         render = {
--             "BufWinEnter",
--             "TabEnter",
--             "TermEnter",
--             "WinEnter",
--             "CmdwinLeave",
--             "TextChanged",
--             "VimResized",
--             "WinScrolled",
--         },
--     },
--     handlers = {
--         diagnostic = true,
--         search = true, -- Requires hlslens to be loaded
--     },
-- })
-- }}}

-- Telescope {{{
require('telescope').setup({
    extensions = {
        command_palette = {
            { "File",
                { "entire selection (C-a)", ':call feedkeys("GVgg")' },
                { "save current file (C-s)", ':w' },
                { "save all files (C-A-s)", ':wa' },
                { "quit (C-q)", ':qa' },
                { "file browser (C-i)", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
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

-- }}}

-- nvim-tree{{{
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

--}}}

-- Rg{{{
-- This is gross. Not rg, just the configuration I do here
vim.api.nvim_exec([[
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    set grepprg=rg\ --vimgrep
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
    command! -bang -nargs=* FindWord call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(expand('<cword>')).'| tr -d "\017"', 1, <bang>0)
endif
]], false)
--}}}

-- specs.nvim {{{
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
-- }}}

-- Treesitter{{{
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
--}}}

-- vsnip {{{
vim.g.vsnip_snippet_dir = os.getenv('HOME') .. "/.config/nvim/vsnip/"
-- }}}

-- vim-markdown {{{
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_no_default_key_mappings = 1
vim.g.vim_markdown_conceal = 1
vim.g.vim_markdown_conceal_code_blocks = 0
vim.g.vim_markdown_strikethrough = 1

vim.o.conceallevel = 2
-- }}}

-- vimiwki {{{
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
-- }}}

-- which-key{{{
require("which-key").setup {
    triggers_blacklist = {
        i = { "<" },
        c = { "h" },
    }
}
--}}}

--}}}

-- User globals {{{
vim.g.nvimtreeOpen = false

vim.g.vistaOpen = false
-- }}}

-- Disabled builtins {{{
-- Improves startup time just ever so slightly
local disabled_built_ins = {
    -- Need netrw for certain things, like remote editing
    -- "netrw",
    -- "netrwPlugin",
    -- "netrwSettings",
    -- "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
--}}}

-- Autocommands {{{

-- Compile packer on save of nvim's init.lua
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*/nvim/init.lua" },
    callback = function()
        os.execute("rm " .. vim.fn.expand("~") .. ".config/nvim/plugin/packer-compiled.lua")
        require("packer").compile()
    end
})

-- Return to previous line in file
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = { "*" },
    callback = function()
        Util.line_return()
    end
})

-- Deal with quickfix
-- set nobuflisted and close if last window
vim.api.nvim_create_augroup("qf", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf" },
    callback = function()
        vim.o.buflisted = false
    end,
    group = "qf",
})

vim.api.nvim_create_autocmd("WinEnter", {
    pattern = { "*" },
    callback = function()
        if vim.fn.winnr('$') == 1 and vim.bo.buftype == "quickfix" then
            vim.cmd [[q]]
        end
    end,
    group = "qf",
})


-- Terminal
vim.api.nvim_create_augroup("Terminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = { "*" },
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.wrap = true
        vim.opt_local.list = true
    end,
    group = "Terminal",
})

vim.api.nvim_create_autocmd("TermClose", {
    pattern = { "*" },
    callback = function()
        vim.cmd(':call feedkeys("i")')
    end,
    group = "Terminal",
})
-- I am putting off rewriting this
vim.cmd [[
    function! NeatFoldText()
        let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
        let lines_count = v:foldend - v:foldstart + 1
        let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
        let foldchar = matchstr(&fillchars, 'fold:\zs.')
        let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
        let foldtextend = lines_count_text . repeat(foldchar, 8)
        let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
        return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
    endfunction
    
    set foldtext=NeatFoldText()
]]

vim.cmd [[
    augroup markdown
        setlocal spell
    augroup end
]]
-- }}}

-- Theme {{{
-- kanagawa {{{
-- moved to packer config
-- }}}

-- gruvbox {{{
-- moved to packer config
--}}}
-- }}}

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

--}}}

-- }}}

-- Mappings {{{

-- inits{{{
local opts = { noremap = true, silent = true }
local map = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, opts)
end

local exmap = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, { noremap = true, expr = true, silent = true })
end
--}}}

-- Vim maps {{{
-- Remap for dealing with word wrap
-- Allows for navigating through wrapped lines without skipping over wrap
exmap('n', 'k', "v:count == 0 ? 'gk' : 'k'")
exmap('n', 'j', "v:count == 0 ? 'gj' : 'j'")

exmap('v', ">", "'>gv'")
exmap('v', "<", "'<gv'")

-- Better incsearch
map("n", "n", "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>")
map("n", "N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>")

-- links for macos
map("n", "gx", 'yiW:!open <C-R>"<CR><Esc>')

-- mksession
map("n", "<leader>mk", ":mksession!")

-- nohl
map("n", "<leader>nh", ":nohl<CR>")

-- Split Terminal
map("n", "<leader>st", ":split term://" .. vimterm .. "<CR>")
map("n", "<leader>vt", ":vsplit term://" .. vimterm .. "<CR>")

-- Current window terminal
map("n", "<leader>tt", ":term<CR>")

-- Term escape
map("t", "<A-z>", "<c-\\><c-n>")

-- switch tabs
map("n", "<Tab>", ':lua Util.skipQF("next")<cr>')
map("n", "<S-Tab>", ':lua Util.skipQF("prev")<cr>')

-- Window/buffer stuff
map("n", "<leader>vs", ":vsplit<cr>")
map("n", "<leader>ss", ":split<cr>")

-- Window movement
map("n", "<A-S-h>", '<cmd>WinShift left<cr>')
map("n", "<A-S-j>", '<cmd>WinShift down<cr>')
map("n", "<A-S-k>", '<cmd>WinShift up<cr>')
map("n", "<A-S-l>", '<cmd>WinShift right<cr>')

-- Close window(split)
map("n", "<A-w>", '<cmd>wincmd c<cr>')

-- Delete buffer
map("n", "<A-q>", ':BDelete! this<cr>')

-- Navigate windows/panes incl. tmux
map("n", "<A-j>", ":lua require('tmux').move_bottom()<CR>")
map("n", "<A-k>", ":lua require('tmux').move_top()<CR>")
map("n", "<A-l>", ":lua require('tmux').move_right()<CR>")
map("n", "<A-h>", ":lua require('tmux').move_left()<CR> ")

map("v", "<A-j>", ":lua require('tmux').move_bottom()<CR>")
map("v", "<A-k>", ":lua require('tmux').move_top()<CR>  ")
map("v", "<A-l>", ":lua require('tmux').move_right()<CR>")
map("v", "<A-h>", ":lua require('tmux').move_left()<CR> ")

map("t", "<A-j>", "<c-\\><c-n>:lua require('tmux').move_bottom()<CR>")
map("t", "<A-k>", "<c-\\><c-n>:lua require('tmux').move_top()<CR>  ")
map("t", "<A-l>", "<c-\\><c-n>:lua require('tmux').move_right()<CR>")
map("t", "<A-h>", "<c-\\><c-n>:lua require('tmux').move_left()<CR> ")

map("n", "<A-C-j>", '<cmd>lua require("tmux").resize_bottom()<cr>')
map("n", "<A-C-k>", '<cmd>lua require("tmux").resize_top()<cr>')
map("n", "<A-C-l>", '<cmd>lua require("tmux").resize_right()<cr>')
map("n", "<A-C-h>", '<cmd>lua require("tmux").resize_left()<cr>')

map("v", "<A-C-j>", '<cmd>lua require("tmux").resize_bottom()<cr>')
map("v", "<A-C-k>", '<cmd>lua require("tmux").resize_top()<cr>')
map("v", "<A-C-l>", '<cmd>lua require("tmux").resize_right()<cr>')
map("v", "<A-C-h>", '<cmd>lua require("tmux").resize_left()<cr>')

map("t", "<A-C-j>", '<c-\\><c-n>:lua require("tmux").resize_bottom()<cr>')
map("t", "<A-C-k>", '<c-\\><c-n>:lua require("tmux").resize_top()<cr>')
map("t", "<A-C-l>", '<c-\\><c-n>:lua require("tmux").resize_right()<cr>')
map("t", "<A-C-h>", '<c-\\><c-n>:lua require("tmux").resize_left()<cr>')
-- }}}

-- Plugin maps {{{

map("n", "<A-f>", ":lua require('maximize').toggle()<cr>")
-- EasyMotion
-- map("n", "<leader>f",    '<cmd>lua require("hop").hint_words()<cr>')

-- Commentary
map("n", "<leader>cm", ':Commentary<cr><esc>')
map("v", "<leader>cm", ':Commentary<cr><esc>')

-- nvim-tree

map("n", "<leader>1", "<cmd>lua Util.nvimTreeToggle()<CR>")
map("t", "<leader>1", "<C-\\><C-n>:lua Util.nvimTreeToggle()<CR>")

map("n", "<leader>2", ":lua Util.toggleTerm()<CR>")
map("t", "<leader>2", "<C-\\><C-n>:lua Util.toggleTerm()<CR>")

-- -- Tagbar
-- map("n", "<leader>3",        "<cmd>lua vistaToggle()<CR>")


map("n", "<leader><leader>", ":Telescope command_palette<cr>")

-- Lazygit
map("n", "<leader>lg", ":lua LazygitFloat()<cr>")

-- Undotree
map("n", "<leader>ud", ":packadd undotree | :UndotreeToggle<CR>")

-- LSP {{{
map('n', '<leader>gy', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<leader>sd', "<cmd>lua vim.lsp.buf.hover()<CR>")
map('n', '<leader>pd', "<cmd>lua require('lspsaga.provider').preview_definition()<CR>")
map("n", "<leader>gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>")
map('n', '<leader>sD', '<cmd>lua vim.diagnostic.open_float()<CR>')
map('n', '<leader>g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<leader>g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<leader>rn', "<cmd>lua require('lspsaga.rename').rename()<CR>")
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

--}}}

-- FZF
map('n', '<leader>pr', ":packadd fzf | :packadd fzf.vim | :Rg<cr>")
map('n', '<leader>pw', ":packadd fzf | :packadd fzf.vim | :FindWord><cr>")

-- Limelight toggles with '!!'
-- map('n', '<leader>li',   '<cmd>Limelight!!<CR>')

-- Obsession
map('n', '<leader>Ob', '<cmd>Obsess<CR>')
map('n', '<leader>OB', '<cmd>Obsess!<CR>')

map("n", "<leader>tf", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>tg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>tb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n", "<leader>th", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

map("n", "<leader>qf", "<cmd>lua require('telescope.builtin').quickfix()<cr>")
map('n', '<leader>ql', "<cmd>lua require('telescope.builtin').loclist()<cr>")
map('n', '<leader>ql', "<cmd>lua require('telescope.builtin').loclist()<cr>")

-- }}}

-- Debug maps {{{
map("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>")
map("n", "<leader>di", "<cmd>lua require('dap').step_into()<CR>")
map("n", "<leader>dn", "<cmd>lua require('dap').step_over()<CR>")
map("n", "<leader>do", "<cmd>lua require('dap').step_out()<CR>")
map("n", "<leader>du", "<cmd>lua require('dap').up()<CR>")
map("n", "<leader>drn", "<cmd>lua require('dap').run_to_cursor()<CR>")
map("n", "<leader>dd", "<cmd>lua require('dap').down()<CR>")
map("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>")
map("n", "<leader>ds", "<cmd>lua require('dapui').open()<cr>")
map("n", "<leader>dS", "<cmd>lua Util.dapStop()<cr>")
-- }}}

-- Language specific maps {{{
-- Go {{{
-- map("n", "<leader>Gie", ":lua goIfErr()<CR>")
-- map("n", "<leader>Gfs", ":lua goFillStruct()<CR>")
--}}}
-- }}}

-- Custom Function maps{{{

map("n", "<leader>sn", ":call SynStack()<cr>")

-- term split like any ol TWM
map("n", "<M-CR>", ":lua Util.newTerm()<cr>")
map("t", "<M-CR>", ":lua Util.newTerm()<cr>")
map("i", "<M-CR>", ":lua Util.newTerm()<cr>")

--}}}

--}}
