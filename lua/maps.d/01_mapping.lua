local map = vim.keymap.set

if vim.loop.os_uname().sysname == "Darwin" then
    map("n", "gx", 'yiW:!open <C-R>"<CR><Esc>')
elseif vim.loop.os_uname().sysname == "Linux" then
    map("n", "gx", 'yiW:!xdg-open <C-R>"<CR><Esc>')
end
-- Fuck `q:` && `F1`
-- https://www.reddit.com/r/neovim/comments/lizyxj/how_to_get_rid_of_q/
-- won't work if you take too long to do perform the action, but that's fine
-- map("n", "q:", "<nop>", { noremap = true })
map("n", "<F1>", "<nop>", { noremap = true })


--Wordwrap
-- Allows for navigating through wrapped lines without skipping over wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Keep selection with visual indentation
map('v', ">", "'>gv'", { expr = true })
map('v', "<", "'<gv'", { expr = true })

-- Better incsearch
map("n", "n", "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>")
map("n", "N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>")

-- focus tabpages
map("n", "<leader><Tab>", ":tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><S-Tab>", ":tabprevious<cr>", { desc = "Previous Tab" })

-- focus buffers
map("n", "<Tab>", function()
    Util.skipUnwantedBuffers("next")
end)
map("n", "<S-Tab>", function()
    Util.skipUnwantedBuffers("prev")
end)


-- Window/buffer stuff
map("n", "<leader>ss", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split Vertical" })

-- Split Terminal
map("n", "<leader>stv", "<cmd>vsplit term://" .. vim.o.shell, { desc = "Vertical Term" })
map("n", "<leader>sts", "<cmd>split term://" .. vim.o.shell, { desc = "Horizontal Term" })


-- Term is set in terminal.lua
map("t", "<C-p>", "<c-\\><c-n>")
map("n", "<leader>tt", TF.Toggle, { desc = "Toggle terminal" })
map("t", "<localleader>tt", TF.Toggle, { desc = "Toggle terminal" })
map("n", "<M-CR>", TF.NewTerm, { desc = "Create new terminal" })
map("t", "<M-CR>", TF.NewTerm, { desc = "Create new terminal" })
map("t", "<c-q>", TF.DeleteCurrentTerm, { desc = "Create new terminal" })
map("t", "<M-r>", TF.RenameTerm, { desc = "Create new terminal" })
map("t", "<M-Tab>", TF.NextTerm, { desc = "Next terminal" })
map("t", "<M-S-Tab>", TF.PrevTerm, { desc = "Previous terminal" })

-- Close window(split)
map("n", "<c-q>", "<cmd>lua require('bufdelete').bufdelete(0, true)<CR>")

-- Delete currently focused buffer
map("n", "<leader>bd", "<cmd>Bdelete<CR>", { silent = true })

-- Window navigation
-- Navigate between panes easily
map("n", "<leader>h", ":wincmd h<cr>", { silent = true })
map("n", "<leader>j", ":wincmd j<cr>", { silent = true })
map("n", "<leader>k", ":wincmd k<cr>", { silent = true })
map("n", "<leader>l", ":wincmd l<cr>", { silent = true })

-- Float
map("n", "<leader>fw", "<cmd> lua Util.Float()<cr>")

-- Telescope
map("n", "<leader>pf", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>pv", ":wincmd v <bar> lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>ph", ":wincmd s <bar> lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>pg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")

-- Git
map("n", "<leader>gs", ":Git | lua Util.Float()<cr>")
map("n", "<leader>gw", ":Gwrite<cr>")
map("n", "<leader>gc", ":Git commit | lua Util.Float()<cr>")
map("n", "<leader>gsh", ":Git push<cr>")
map("n", "<leader>gll", ":Git pull<cr>")
map("n", "<leader>gb", ":Git blame | lua Util.Float()<cr>")
map("n", "<leader>gvd", ":Gvdiff<cr>")
map("n", "<leader>gr", ":GRemove<cr>")
map("n", "<leader>o", ":GBrowse<cr>")
map("n", "<leader>gj", ":diffget //3<cr>")
map("n", "<leader>gf", ":diffget //2<cr>")


-- Commentary
map("n", "<leader>cm", ':Commentary<cr><esc>', { silent = true })
map("v", "<leader>cm", ':Commentary<cr><esc>', { silent = true })

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

-- Filetree
map("n", "<leader>ft", "NvimTreeToggle")
