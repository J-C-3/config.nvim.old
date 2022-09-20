--- Mappings {{{
-- inits {{{
local opts = { noremap = true, silent = true }
local map = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, opts)
end

local exmap = function(mode, keys, command)
    vim.api.nvim_set_keymap(mode, keys, command, { noremap = true, expr = true, silent = true })
end
-- Vim Maps {{{
-- Source the init
map("n", "<leader><cr>", ":source ~/.config/nvim/init.lua<cr>")

-- Terminal
map("n", "<leader>sh", ":terminal<cr>")
map("t", "<C-p>", "<C-\\><C-n>")

--- Buffer navigation
--- :lua Util.skipQF("prev")<cr>
-- map("n", "<leader>bd", ":BDelete this<CR>")
map("n", "<leader>bd", ":bp<bar>sp<bar>bn<bar>bd<cr>")
map("n", "<leader>pb", "<cmd>lua require('telescope.builtin').buffers()<cr>")

-- Navigate between panes easily
map("n", "<leader>h", ":wincmd h<cr>")
map("n", "<leader>j", ":wincmd j<cr>")
map("n", "<leader>k", ":wincmd k<cr>")
map("n", "<leader>l", ":wincmd l<cr>")

-- Splits
map("n", "<leader>+", ":vertical resize +5<CR>")
map("n", "<leader>-", ":vertical resize -5<CR>")

-- Telescope
map("n", "<leader>pf", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>pv", ":wincmd v <bar> lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>ph", ":wincmd s <bar> lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>pg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>ph", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- }}}
-- Git {{{
map("n", "<leader>gs", ":Git<CR>")
map("n", "<leader>gw", ":Gwrite<CR>")
map("n", "<leader>gc", ":Git commit<CR>")
map("n", "<leader>gsh", ":Git push<CR>")
map("n", "<leader>gll", ":Git pull<CR>")
map("n", "<leader>gb", ":Git blame<CR>")
map("n", "<leader>gd", ":Gvdiff<CR>")
map("n", "<leader>gr", ":Gremove<CR>")
map("n", "<leader>o", ":Gbrowse<CR>")
map("n", "<leader>gj", ":diffget //3<CR>")
map("n", "<leader>gf", ":diffget //2<CR>")
-- }}}
-- }}}
--}}}
