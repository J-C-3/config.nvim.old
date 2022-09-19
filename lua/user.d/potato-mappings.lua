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
<<<<<<< HEAD
-- map("n", "<leader>bd", ":BDelete this<CR>")
map("n", "<leader>bd", ":bp<bar>sp<bar>bn<bar>bd<cr>")
map("n", "<leader>pb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
=======
map("n", "<leader>bd", ":BDelete this<CR>")
map("n", "<leader>tb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
>>>>>>> 7b71319 (personalized configuration)

-- Navigate between panes easily
map("n", "<leader>h", ":wincmd h<cr>")
map("n", "<leader>j", ":wincmd j<cr>")
map("n", "<leader>k", ":wincmd k<cr>")
map("n", "<leader>l", ":wincmd l<cr>")

-- Splits
map("n", "<leader>+", ":vertical resize +5<CR>")
map("n", "<leader>-", ":vertical resize -5<CR>")

<<<<<<< HEAD
-- Float
map("n", "<leader>fw", "<cmd> lua Float()<cr>")

-- Telescope
map("n", "<leader>pf", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>pv", ":wincmd v <bar> lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>ph", ":wincmd s <bar> lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>pg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>ph", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- }}}
-- Git {{{
map("n", "<leader>gs", ":Git | lua Float()<cr>")
map("n", "<leader>gw", ":Gwrite<cr>")
map("n", "<leader>gc", ":Git commit | lua Float()<cr>")
map("n", "<leader>gsh", ":Git push<cr>")
map("n", "<leader>gll", ":Git pull<cr>")
map("n", "<leader>gb", ":Git blame | lua Float()<cr>")
map("n", "<leader>gd", ":Gvdiff<cr>")
map("n", "<leader>gr", ":GRemove<cr>")
map("n", "<leader>o", ":GBrowse<cr>")
map("n", "<leader>gj", ":diffget //3<cr>")
map("n", "<leader>gf", ":diffget //2<cr>")
-- }}}
-- }}}
--}}
-- }
