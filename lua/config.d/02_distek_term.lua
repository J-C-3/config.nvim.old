-- Term Framework
T = require("nvim-terminal")

TF = {}

TF.Term = {}

-- initial tab setup
TF.Term[vim.api.nvim_get_current_tabpage()] = T.NewTerminalInstance({
    pos = "botright",
    split = "sp",
    height = 15,
})

vim.api.nvim_create_autocmd({ "TabNewEntered" }, {
    pattern = "*",
    callback = function(ev)
        if TF.Term[vim.api.nvim_get_current_tabpage()] == nil then
            TF.Term[vim.api.nvim_get_current_tabpage()] = T.NewTerminalInstance({
                pos = "botright",
                split = "sp",
                height = 15,
            })
        end
    end
})

TF.NewTerm = function()
    local nvt = require("nvim-tree.view").is_visible()
    if nvt then
        require("nvim-tree.api").tree.close()
    end

    TF.Term[vim.api.nvim_get_current_tabpage()]:open(#TF.Term[vim.api.nvim_get_current_tabpage()].bufs + 1)
    TF.UpdateWinbar()

    if nvt then
        require("nvim-tree.api").tree.open()
        vim.cmd("wincmd p")
    end
end

TF.Open = function()
    local nvt = require("nvim-tree.view").is_visible()
    if nvt then
        require("nvim-tree.api").tree.close()
    end

    TF.Term[vim.api.nvim_get_current_tabpage()]:open(TF.Term[vim.api.nvim_get_current_tabpage()].last_term)
    TF.UpdateWinbar()

    if nvt then
        require("nvim-tree.api").tree.open()
        vim.cmd("wincmd p")
    end
end

TF.Toggle = function()
    local nvt = require("nvim-tree.view").is_visible()
    if nvt then
        require("nvim-tree.api").tree.close()
    end

    TF.Term[vim.api.nvim_get_current_tabpage()]:toggle()
    local winid = TF.Term[vim.api.nvim_get_current_tabpage()].window.winid

    TF.UpdateWinbar()

    if nvt then
        require("nvim-tree.api").tree.open()
        vim.cmd("wincmd p")
    end
end

TF.PickTerm = function()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local conf = require("telescope.config").values

    local opts = require("telescope.themes").get_dropdown({})

    local termPretty = {}
    local termBufs = {}
    for i, v in ipairs(TF.Term[vim.api.nvim_get_current_tabpage()].bufs) do
        table.insert(termPretty, string.format("%d: %s", i, vim.api.nvim_buf_get_var(v, "name")))
        table.insert(termBufs, i)
    end

    pickers
        .new(opts, {
            prompt_title = "Terminals",
            finder = finders.new_table({
                results = termPretty,
            }),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()

                    if selection == nil then
                        return
                    end

                    local nvt = require("nvim-tree.view").is_visible()
                    if nvt then
                        require("nvim-tree.api").tree.close()
                    end

                    TF.Term[vim.api.nvim_get_current_tabpage()]:open(termBufs[selection.index])
                    TF.UpdateWinbar()

                    if nvt then
                        require("nvim-tree.api").tree.open()
                        vim.cmd("wincmd p")
                    end
                end)

                return true
            end,
        })
        :find()
end

TF.RenameTerm = function()
    if TF.Term[vim.api.nvim_get_current_tabpage()].last_term == nil then
        return
    end

    vim.ui.input({
        prompt = "New name: ",
    }, function(input)
        if input ~= "" then
            vim.api.nvim_buf_set_var(TF.Term[vim.api.nvim_get_current_tabpage()].bufs[
                TF.Term[vim.api.nvim_get_current_tabpage()].last_term], "name", input)
            return
        end
    end)
    TF.UpdateWinbar()
end

TF.UpdateWinbar = function()
    local tp = vim.api.nvim_get_current_tabpage()
    local winid = vim.fn.bufwinid(TF.Term[tp].bufs[TF.Term[tp].last_term])
    local count = #TF.Term[tp].bufs

    if winid < 0 then
        return
    end

    local wb = ""

    for i, v in ipairs(TF.Term[tp].bufs) do
        if v == TF.Term[tp].bufs[TF.Term[tp].last_term] then
            wb = wb .. "%#BufferLineTabSelected#▎"
            wb = wb .. "%#BufferLineHintSelected# "
        else
            wb = wb .. "%#BufferLineSeparatorVisible#▎%#BufferLineHintVisible# "
        end

        wb = wb .. "%" .. i .. "@v:lua.TF.HandleClickTab@ "
        wb = wb .. vim.api.nvim_buf_get_var(v, "name") .. " %X"
        wb = wb .. "%" .. i .. "@v:lua.TF.HandleClickClose@"
        wb = wb .. " %X"
        if count > 1 and i ~= count then
            wb = wb .. " %#BufferLineFill# "
        else
            wb = wb .. " "
        end
        wb = wb .. "%#Normal#"
    end

    wb = wb .. "%#BufferLineFill#"

    vim.wo[winid].winbar = wb
end

TF.HandleClickTab = function(minwid, clicks, btn, mods)
    TF.Term[vim.api.nvim_get_current_tabpage()]:open(minwid)
    TF.UpdateWinbar()
end

TF.HandleClickClose = function(minwid, clicks, btn, mods)
    local tp = vim.api.nvim_get_current_tabpage()
    if TF.Term[tp]:delete(minwid) then
        TF.UpdateWinbar()
    end
end

TF.DeleteCurrentTerm = function()
    local tp = vim.api.nvim_get_current_tabpage()
    local lt = TF.Term[tp].last_term
    if TF.Term[tp]:delete(lt) then
        TF.UpdateWinbar()
    end
end

TF.NextTerm = function()
    local nextTerm = TF.Term[vim.api.nvim_get_current_tabpage()].last_term + 1

    if TF.Term[vim.api.nvim_get_current_tabpage()].bufs[nextTerm] == nil then
        nextTerm = 1
    end

    TF.Term[vim.api.nvim_get_current_tabpage()]:open(nextTerm)
    TF.UpdateWinbar()
end

TF.PrevTerm = function()
    local nextTerm = TF.Term[vim.api.nvim_get_current_tabpage()].last_term - 1

    if TF.Term[vim.api.nvim_get_current_tabpage()].bufs[nextTerm] == nil then
        nextTerm = #TF.Term[vim.api.nvim_get_current_tabpage()].bufs
    end

    TF.Term[vim.api.nvim_get_current_tabpage()]:open(nextTerm)
    TF.UpdateWinbar()
end

vim.api.nvim_create_autocmd({ "VimResized" }, {
    pattern = "*",
    callback = function()
        TF.Term[vim.api.nvim_get_current_tabpage()].window:update_size()
    end,
})
