local opts = { noremap = true, silent = true }
local map = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, opts)
end

local exmap = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, { noremap = true, expr = true, silent = true })
end

-- mksession
map("n", "<leader>mk", ":mksession!")
-- links
if vim.loop.os_uname().sysname == "Darwin" then
    map("n", "gx", 'yiW:!open <C-R>"<CR><Esc>')
elseif vim.loop.os_uname().sysname == "Linux" then
    map("n", "gx", 'yiW:!xdg-open <C-R>"<CR><Esc>')
end

-- nohl
map("n", "<leader>nh", ":nohl<CR>")

-- Split Terminal
map("n", "<leader>st", ":split term://" .. Vimterm .. "<CR>")
map("n", "<leader>vt", ":vsplit term://" .. Vimterm .. "<CR>")

-- Current window terminal
map("n", "<leader>tt", ":term<CR>")

-- Term escape
map("t", "<A-z>", "<c-\\><c-n>")

-- Close window(split)
map("n", "<A-w>", '<cmd>wincmd c<cr>')

-- Delete buffer
map("n", "<A-q>", ':BDelete! this<cr>')

-- Window movement
map("n", "<A-S-h>", '<cmd>WinShift left<cr>')
map("n", "<A-S-j>", '<cmd>WinShift down<cr>')
map("n", "<A-S-k>", '<cmd>WinShift up<cr>')
map("n", "<A-S-l>", '<cmd>WinShift right<cr>')


-- Navigate windows/panes incl. tmux
map("n", "<A-j>", "<cmd>lua require('tmux').move_bottom()<CR>")
map("n", "<A-k>", "<cmd>lua require('tmux').move_top()<CR>")
map("n", "<A-l>", "<cmd>lua require('tmux').move_right()<CR>")
map("n", "<A-h>", "<cmd>lua require('tmux').move_left()<CR>")

map("v", "<A-j>", "<cmd>lua require('tmux').move_bottom()<CR>")
map("v", "<A-k>", "<cmd>lua require('tmux').move_top()<CR>")
map("v", "<A-l>", "<cmd>lua require('tmux').move_right()<CR>")
map("v", "<A-h>", "<cmd>lua require('tmux').move_left()<CR>")

map("t", "<A-j>", "<cmd>lua require('tmux').move_bottom()<CR>")
map("t", "<A-k>", "<cmd>lua require('tmux').move_top()<CR>")
map("t", "<A-l>", "<cmd>lua require('tmux').move_right()<CR>")
map("t", "<A-h>", "<cmd>lua require('tmux').move_left()<CR>")

map("n", "<A-C-j>", '<cmd>lua require("tmux").resize_bottom()<cr>')
map("n", "<A-C-k>", '<cmd>lua require("tmux").resize_top()<cr>')
map("n", "<A-C-l>", '<cmd>lua require("tmux").resize_right()<cr>')
map("n", "<A-C-h>", '<cmd>lua require("tmux").resize_left()<cr>')

map("v", "<A-C-j>", '<cmd>lua require("tmux").resize_bottom()<cr>')
map("v", "<A-C-k>", '<cmd>lua require("tmux").resize_top()<cr>')
map("v", "<A-C-l>", '<cmd>lua require("tmux").resize_right()<cr>')
map("v", "<A-C-h>", '<cmd>lua require("tmux").resize_left()<cr>')

map("t", "<A-C-j>", '<cmd>lua require("tmux").resize_bottom()<cr>')
map("t", "<A-C-k>", '<cmd>lua require("tmux").resize_top()<cr>')
map("t", "<A-C-l>", '<cmd>lua require("tmux").resize_right()<cr>')
map("t", "<A-C-h>", '<cmd>lua require("tmux").resize_left()<cr>')

-- Plugin maps

map("n", "<A-f>", ":lua require('maximize').toggle()<cr>")

-- Commentary
map("n", "<leader>cm", ':Commentary<cr><esc>')
map("v", "<leader>cm", ':Commentary<cr><esc>')

-- nvim-tree

map("n", "<leader>1", "<cmd>lua Util.nvimTreeToggle()<CR>")
map("t", "<leader>1", "<cmd>lua Util.nvimTreeToggle()<CR>")

-- toggleterm
map("n", "<leader>2", "<cmd>lua Util.toggleTerm()<CR>")
map("t", "<leader>2", "<cmd>lua Util.toggleTerm()<CR>")

-- float toggleterm
map("n", "<leader>ft", "<cmd>lua NormalTermFloat()<CR>")
map("t", "<leader>ft", "<cmd>lua NormalTermFloat()<CR>")

-- -- Tagbar
map("n", "<leader>3", "<cmd>lua Util.tagbarToggle()<CR>")


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

map('n', '<leader>pr', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map('n', '<leader>pw', "<cmd>lua require('telescope.builtin').grep_string()<cr>")

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

-- Debug maps
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

-- Custom Function maps
map("n", "<leader>sn", ":call SynStack()<cr>")

-- term split like any ol TWM
map("n", "<M-CR>", "<cmd>lua Util.newTerm()<cr>")
map("t", "<M-CR>", "<cmd>lua Util.newTerm()<cr>")
map("i", "<M-CR>", "<cmd>lua Util.newTerm()<cr>")
