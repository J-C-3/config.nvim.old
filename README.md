# config.nvim

Personal nvim distro

## Dependencies
* `nvim`
* `git`
* some `cc` compiler like `clang` or `gcc`

## Install
```
git clone https://github.com/distek/config.nvim.git ~/.config/nvim
```

Then:
* run `nvim`
    * After the initial clone of packer, it will begin to install plugins.
    * Press enter or something after packer shows "finished"
* wait for the treesitter parsers to compile
    * if some of the compilers fail, wait until it's finished and then close and reopen `nvim` and it will attempt to restart

This is about as clean and simple as I can get the init. The autocmd packer provides in the readme doesn't seem to work, but I'm sure that's likely my fault.

## Notes

### Another fuckin neovim distro?
Yeah I know right?

I don't care about making this necessarily easier to configure, though.

We're just rockin' lua over here so do what you want and there's no weird configuration syntax thing you have to figure out other than the `.d` directories. Which if you've used a unix-like for a reasonable amount of time you've probably already seen and kinda get the gist of.

Also I probably wont advertise this everywhere as I have no time to _actually_ support it. Though I rock neovim's nightly and will keep it functional with that.

### It's not _BLAZINGlY FAST_ to open
I haven't spent an ungodly amount of time trying to get this config to open in less than 10ms.

It opens faster than vscode or whatever IDE one might use, so it's good enough for me.

### Theme

Gruvbox and Kanagawa are setup by default in `lua/defaults.d/themes.lua`. Gruvbox is the default theme.
To add nord, for example:

- In `lua/user.d/yourname-plugins.lua`:
```lua

use {
    'shaunsingh/nord.nvim',
}

```

- The configuration for the various themes are set in a function that's assigned to a key in the `Themes` table:
```lua
-- Adding nord (in lua/user.d/yourname-themes.lua):
Themes = {
    ["nord"] = function()
        vim.g.nord_contrast = true
        vim.g.nord_borders = true
        vim.g.nord_disable_background = false
        vim.g.nord_enable_sidebar_background = true
        vim.g.nord_cursorline_transparent = false
        vim.g.nord_italic = true

        require('nord').set()

        vim.cmd('highlight CursorLine guibg='..Util.darken(Util.getColor("Normal", "bg#"), 0.8))
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

Also, despite them being `.d` directories, you don't _have_ to number them, though they're called in alphabetical order after the order specified in `init.lua`:

```lua
if vim.g.vscode then
    require('vscode')
else
    vim.o.runtimepath = vim.o.runtimepath .. ',' .. vim.fn.stdpath("data") .. "/packer/"

    local firstRun = require('plugins')

    if firstRun then
        require('packer').install()
    else
        require('packer').compile()

        require('util')

        Util.extraConfs('defaults.d') -- you can add your own ".d" directories, if you want
        Util.extraConfs('user.d')
    end
end
```
