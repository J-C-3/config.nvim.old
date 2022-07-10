local lazygitCfg = {
    cmd = "lazygit",
    direction = "float",
}

local lazygit = require('toggleterm.terminal').Terminal:new(lazygitCfg)

function LazygitFloat()
    lazygit:toggle()
end

local normalTermCfg = {
    cmd = Vimterm,
    direction = "float",
}

local normalTerm = require('toggleterm.terminal').Terminal:new(normalTermCfg)

function NormalTermFloat()
    normalTerm:toggle()
end
