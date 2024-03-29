local opts = { noremap = true, silent = true }
local map = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, opts)
end

local exmap = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, { noremap = true, expr = true, silent = true })
end

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
map("n", "<A-q>", '<cmd>wincmd c<cr>')

-- Delete buffer
map("n", "<A-S-q>", '<cmd>bd<cr>')

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

-- Zen
map("n", "<leader>z", ':ZenMode<cr>')

-- Commentary
map("n", "<leader>cm", ':Commentary<cr><esc>')
map("v", "<leader>cm", ':Commentary<cr><esc>')

-- nvim-tree
map("n", "<leader>1", "<cmd>Telescope file_browser path=%:p:h<CR>")
map("t", "<leader>1", "<cmd>Telescope file_browser path=%:p:h<CR>")

-- toggleterm
map("n", "<leader>2", "<cmd>lua Util.toggleTerm()<CR>")
map("t", "<leader>2", "<cmd>lua Util.toggleTerm()<CR>")

-- float toggleterm
map("n", "<leader>ft", "<cmd>lua NormalTermFloat()<CR>")
map("t", "<leader>ft", "<cmd>lua NormalTermFloat()<CR>")

-- -- Tagbar
map("n", "<leader>3", "<cmd>lua Util.tagbarToggle()<CR>")

-- Lazygit
map("n", "<leader>lg", ":lua LazygitFloat()<cr>")

-- Undotree
map("n", "<leader>ud", ":packadd undotree | :UndotreeToggle<CR>")

-- LSP
map('n', '<leader>gy', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<leader>sd', "<cmd>Lspsaga hover_doc<CR>")
map('n', '<leader>pd', "<cmd>Lspsaga preview_definition<CR>")
map("n", "<leader>gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>")
map('n', '<leader>sD', '<cmd>Lspsaga show_line_diagnostics<CR>')
map('n', '<leader>g[', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
map('n', '<leader>g]', '<cmd>Lspsaga diagnostic_jump_next<CR>')
map('n', '<leader>rn', "<cmd>Lspsaga rename<CR>")
map('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>')

-- Telescopic Johnson
map('n', '<leader>pr', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map('n', '<leader>pw', "<cmd>lua require('telescope.builtin').grep_string()<cr>")

-- Limelight toggles with '!!'
-- map('n', '<leader>li',   '<cmd>Limelight!!<CR>')

map("n", "<leader>tf", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>tg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>tb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n", "<leader>th", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

map("n", "<leader>qf", "<cmd>lua require('telescope.builtin').quickfix()<cr>")
map('n', '<leader>ql', "<cmd>lua require('telescope.builtin').loclist()<cr>")

map('n', '<leader>pp', "<cmd>Telescope projects<cr>")

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

-- term split like any ol TWM
map("n", "<M-CR>", "<cmd>lua Util.newTerm()<cr>")
map("t", "<M-CR>", "<cmd>lua Util.newTerm()<cr>")
map("i", "<M-CR>", "<cmd>lua Util.newTerm()<cr>")

-- refactoring.nvim
map("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]])
map("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]])
map("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]])
map("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])

map("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]])
map("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]])

map("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])

-- Meta LSP stuff
map("n", "<leader>Li", "<cmd>LspInstallInfo<CR>")
map("n", "<leader>Lr", "<cmd>LspRestart<CR>")
map("n", "<leader>Ls", "<cmd>LspStart<CR>")
map("n", "<leader>LS", "<cmd>LspStop<CR>")

-- Fugitive
map("n", "<leader>gfs", "<cmd>vert Git<cr>")
map("n", "<leader>gfc", "<cmd>Git commit<cr>")
map("n", "<leader>gfp", "<cmd>Git push<cr>")
map("n", "<leader>gfl", "<cmd>Gclog<cr>")

-- Sessions
map("n", "<leader>Ps", "<cmd>SaveSession<CR>")
map("n", "<leader>Pl", "<cmd>SearchSession<CR>")
map("n", "<leader>Pd", "<cmd>Autosession delete<CR>")

-- Fuck q:
-- https://www.reddit.com/r/neovim/comments/lizyxj/how_to_get_rid_of_q/
-- wont work if you take too long to do perform the action, but that's fine
map("n", "q:", "<nop>")
