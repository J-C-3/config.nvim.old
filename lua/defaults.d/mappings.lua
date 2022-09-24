-- Mappings

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

-- focus buffers
map("n", "<Tab>", ':lua Util.skipQFAndTerm("next")<cr>')
map("n", "<S-Tab>", ':lua Util.skipQFAndTerm("prev")<cr>')

-- move buffers
map("n", "<A-Tab>", '<Cmd>lua require"cokeline/mappings".by_step("switch", 1)<CR>')
map("n", "<A-S-Tab>", '<Cmd>lua require"cokeline/mappings".by_step("switch", -1)<CR>')

-- Window/buffer stuff
map("n", "<leader>vs", ":vsplit<cr>")
map("n", "<leader>ss", ":split<cr>")

-- }}}
