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
vim.o.shell = "/usr/bin/env zsh"
-- Vimterm = vim.fn.expand("~") .. "/.config/nvim/scripts/vimterm.sh"
Vimterm = vim.o.shell
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
vim.cmd [[set guifont=FiraCode\ Nerd\ Font\ Mono:h10]]
vim.cmd [[set guicursor+=a:blinkon650]]

-- netrw Sexplore or Lexplore
vim.cmd [[let g:netrw_winsize = 20]]

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
--}}}

-- User globals {{{
vim.g.nvimtreeOpen = false

vim.g.tagbarOpen = false
-- }}}

