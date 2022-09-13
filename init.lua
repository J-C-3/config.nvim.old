-- Nvim config
if vim.g.vscode then
    local function remove(input, path)
        local retTable = {}
        local ret = ""

        for s in string.gmatch(input, "([^,]+)") do
            if string.match(s, path) == nil then
                table.insert(retTable, s)
            end
        end

        for _, v in pairs(retTable) do
            ret = ret..v..","
        end

        return ret
    end

    local newPackPath = remove(vim.o.packpath, ".local/share/nvim/site")
    local newRuntimePath = remove(vim.o.runtimepath, ".local/share/nvim/site/pack(.*)")

    vim.o.packpath = newPackPath
    vim.o.runtimepath = newRuntimePath

    vim.cmd [[filetype off]]

    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- vim.o.autoread = true
    vim.backspace = { "indent", "eol", "start" }
    -- vim.o.breakindent = true
    vim.o.clipboard = "unnamedplus"
    -- vim.o.cmdheight = 1
    -- vim.wo.colorcolumn = "80"
    -- vim.o.cursorline = true
    -- vim.o.encoding = "utf-8"
    -- vim.o.expandtab = true
    -- vim.o.fileformats = "unix,dos,mac"
    vim.cmd [[filetype plugin indent on]]
    -- vim.o.fillchars = "vert:│,fold:-,eob: "
    -- vim.o.foldmethod = "marker"
    -- vim.o.hidden = true
    -- vim.o.hlsearch = true
    vim.o.ignorecase = true
    vim.o.inccommand = "nosplit"
    -- vim.o.incsearch = true
    -- vim.opt.laststatus = 3
    -- vim.o.linebreak = true
    -- vim.o.modeline = true
    -- vim.o.modelines = 5
    -- vim.o.mouse = "a"
    -- vim.o.number = true
    -- vim.o.numberwidth = 5
    -- vim.o.pumblend = 15
    -- vim.o.relativenumber = true
    -- vim.o.ruler = true
    -- vim.o.scrolloff = 2
    -- vim.o.shell = os.getenv("SHELL")
    -- -- Vimterm = vim.fn.expand("~") .. "/.config/nvim/scripts/vimterm.sh"
    -- Vimterm = vim.o.shell
    -- vim.o.shiftwidth = 4
    -- vim.o.showbreak = "↪ "
    -- vim.o.showmode = false
    -- vim.o.showtabline = 2
    -- vim.o.signcolumn = "yes:2"
    vim.o.smartcase = true
    -- vim.o.softtabstop = 0
    -- vim.opt.spell = false
    -- vim.opt.spelllang = { 'en_us' }
    vim.o.startofline = 0
    -- vim.o.syntax = "on"
    -- vim.o.tabstop = 4
    -- vim.o.termguicolors = true
    -- vim.o.timeoutlen = 250
    -- vim.o.updatetime = 250
    -- vim.o.wildignore = "*.o,*.obj,.git,*.rbc,*.pyc,__pycache__"
    -- vim.o.wildmode = "list:longest,list:full"
    -- vim.o.wrap = true

    vim.cmd [[set sessionoptions-=blank]]

    vim.o.swapfile = false
    vim.o.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
    vim.o.undofile = true

    local opts = { noremap = true, silent = true }
    local map = function(mode, keys, command)
        vim.api.nvim_set_keymap(mode, keys, command, opts)
    end

    local exmap = function(mode, keys, command)
        vim.api.nvim_set_keymap(mode, keys, command, { noremap = true, expr = true, silent = true })
    end

    exmap('n', 'k', "v:count == 0 ? 'gk' : 'k'")
    exmap('n', 'j', "v:count == 0 ? 'gj' : 'j'")

    exmap('v', ">", "'>gv'")
    exmap('v', "<", "'<gv'")

    map('v', "<leader>cm", "<Plug>VSCodeCommentarygv<Esc>")
    map('n', "<leader>cm", "<Plug>VSCodeCommentaryLine<Esc>")

    map('n', "<leader>sd", "<Cmd>call VSCodeNotify('editor.action.showHover')<CR>")
    map('n', "<leader>gd", "<Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>")

    map('n', "<leader>rn", "<Cmd>call VSCodeNotify('editor.action.rename')<CR>")

    map('n', "<leader>ca", "<Cmd>call VSCodeNotify('problems.action.showQuickFixes')<CR>")

    map('n', "<leader>nh", ":nohl<cr>")

else
    local packerInstall = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

    require('util')
    require('plugins')
    if vim.fn.empty(vim.fn.glob(packerInstall)) == 0 then
        Util.extraConfs('defaults.d')
        Util.extraConfs('user.d')
    end
end
