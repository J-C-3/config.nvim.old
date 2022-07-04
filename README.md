# config.nvim

Personal nvim distro

## Dependencies
* `nvim`

## Install
```
git clone https://github.com/distek/config.nvim.git ~/.config/nvim
```

Then:
* run `nvim`
    * You'll get an error, probably for `gitsigns`, just hit enter and Packer will start installing plugins
* close `nvim` once packer finishes and/or closes
* reopen to let TreeSitter compile it's parsers
* use nvim, feel the lua

## Notes

### Another fuckin neovim distro?
Yeah I know right?

I don't care about making this necessarily easier to configure, though.

We're just rockin' lua over here so do what you want and there's no weird configuration syntax thing you have to figure out other than the `.d` directories. Which if you've used a unix-like for a reasonable amount of time you've probably already seen and kinda get the gist of.

Also I probably wont advertise this everywhere as I have no time to _actually_ support it. Though I rock neovim's nightly and will keep it functional with that.

### Theme

Gruvbox and Kanagawa are setup by default in `lua/defaults.d/themes.lua`. Gruvbox is the default theme.
The configuration for the various themes are set in a function that's assigned to a key in the `Themes` table:
```lua
-- Adding nord:
Themes = {
    ["nord"] = function()
        vim.g.nord_contrast = true
        vim.g.nord_borders = true
        vim.g.nord_disable_background = false
        vim.g.nord_enable_sidebar_background = true
        vim.g.nord_cursorline_transparent = false
        vim.g.nord_italic = true

        require('nord').set()

        vim.cmd('highlight CursorLine guibg='..Darken(Util.getColor("Normal", "bg#"), 0.8))
    end
}

-- To change the theme, uncomment the line for the desired theme in `lua/user.d/distek-themes.lua`:
-- Uncomment/comment here:
-- Themes.gruvbox()
-- Themes.kanagawa()
Themes.nord()
```

### LSP

To install LSPs for whatever language:

```
:LspInstall [language]
```

or just

```
:LspInstall
```

Which will bring up a dialog to select the desired LSP client for the current filetype's language (if any).

### config.d-like extensions

* An attempt at sane defaults has been set in `lua/defaults.d/*`
* Updates to these, or changes to, the settings found therein should go in `lua/user.d/*`

```
lua
├── defaults.d
│   ├── autocmds.lua
│   ├── globals.lua
│   ├── lsp-conf.lua
│   ├── mappings.lua
│   └── themes.lua
├── plugins.lua
├── user.d
│   ├── distek-mappings.lua
│   ├── distek-plugins.lua
│   └── distek-themes.lua
└── util.lua
```

I've left my configurations in these directories as examples of how to utilize them. _Most_ of the mappings have been moved from the defaults directory as I've come to find that a lot of what I remap is _wild_ and _crazy_ :)

Also, despite them being `.d` directories, you don't have to number them. They're just called in alphabetical order after the order specified in `init.lua`:

```lua
-- Nvim config
local packerInstall = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

require('util')
require('plugins')
if vim.fn.empty(vim.fn.glob(packerInstall)) == 0 then
    Util.extraConfs('defaults.d')
    Util.extraConfs('user.d')
end
```
