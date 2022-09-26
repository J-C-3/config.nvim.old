vim.g.gui_font_default_size = 16
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "FiraCode Nerd Font Mono"

vim.g.neovide_input_use_logo = false
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_confirm_quit = true

vim.cmd [[set guicursor+=a:blinkon650]]


RefreshGuiFont = function()
    vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
    vim.g.gui_font_size = vim.g.gui_font_size + delta
    RefreshGuiFont()
end

ResetGuiFont = function()
    vim.g.gui_font_size = vim.g.gui_font_default_size
    RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'i' }, "<C-=>", function() ResizeGuiFont(1) end, opts)
vim.keymap.set({ 'n', 'i' }, "<C-->", function() ResizeGuiFont(-1) end, opts)

local opts = { noremap = true, silent = true }
local map = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, opts)
end

local exmap = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, { noremap = true, expr = true, silent = true })
end
-- Term escape
map("t", "Ω", "<c-\\><c-n>")

-- Close window(split)
map("n", "œ", '<cmd>wincmd c<cr>')

-- Delete buffer
map("n", "Œ", ':BDelete! this<cr>')

-- Window movement
map("n", "Ó", '<cmd>WinShift left<cr>')
map("n", "Ô", '<cmd>WinShift down<cr>')
map("n", "", '<cmd>WinShift up<cr>')
map("n", "Ò", '<cmd>WinShift right<cr>')


-- Navigate windows/panes incl. tmux
map("n", "∆", "<cmd>lua require('tmux').move_bottom()<CR>")
map("n", "˚", "<cmd>lua require('tmux').move_top()<CR>")
map("n", "¬", "<cmd>lua require('tmux').move_right()<CR>")
map("n", "˙", "<cmd>lua require('tmux').move_left()<CR>")

map("v", "∆", "<cmd>lua require('tmux').move_bottom()<CR>")
map("v", "˚", "<cmd>lua require('tmux').move_top()<CR>")
map("v", "¬", "<cmd>lua require('tmux').move_right()<CR>")
map("v", "˙", "<cmd>lua require('tmux').move_left()<CR>")

map("t", "∆", "<cmd>lua require('tmux').move_bottom()<CR>")
map("t", "˚", "<cmd>lua require('tmux').move_top()<CR>")
map("t", "¬", "<cmd>lua require('tmux').move_right()<CR>")
map("t", "˙", "<cmd>lua require('tmux').move_left()<CR>")

map("n", "<C-∆>", '<cmd>lua require("tmux").resize_bottom()<cr>')
map("n", "<C-˚>", '<cmd>lua require("tmux").resize_top()<cr>')
map("n", "<C-¬>", '<cmd>lua require("tmux").resize_right()<cr>')
map("n", "<C-˙>", '<cmd>lua require("tmux").resize_left()<cr>')

map("v", "<C-∆>", '<cmd>lua require("tmux").resize_bottom()<cr>')
map("v", "<C-˚>", '<cmd>lua require("tmux").resize_top()<cr>')
map("v", "<C-¬>", '<cmd>lua require("tmux").resize_right()<cr>')
map("v", "<C-˙>", '<cmd>lua require("tmux").resize_left()<cr>')

map("t", "<C-∆>", '<cmd>lua require("tmux").resize_bottom()<cr>')
map("t", "<C-˚>", '<cmd>lua require("tmux").resize_top()<cr>')
map("t", "<C-¬>", '<cmd>lua require("tmux").resize_right()<cr>')
map("t", "<C-˙>", '<cmd>lua require("tmux").resize_left()<cr>')

map("c", "<C-S-v>", '<c-r>+')
map("i", "<C-S-v>", '<c-r>+')
