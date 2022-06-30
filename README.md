# config.nvim

Personal nvim distro

## Dependencies
* `nvim`
* ~`tmux`~ - Tentatively removed as it might just be more trouble than it's worth.

### ~Why `tmux`?~
~Currently neovim's terminal does not have proper reflow support; If the terminal is shrunk horizontally, it will cut off text permanently; If it is grown horizontally, it will not wrap lines properly. `vimterm.sh` uses a super basic tmux config to sort of emulate a proper terminal.~

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

### LSP

To install LSPs for whatever language:

```
:LspInstall [language]
```

or just

```
:LspInstall
```

Which will bring up a dialog to select the desired LSP client.

### Mappings

Change them to whatever.

### config.d-like extensions

In `lua/`, config.d-like directories can be added for the various categories (can be custom names as well).
* example: `lua/plugins.d/` can contain something like `git-things.lua` which can look like:
```
local use = require('packer').use

use { 'tpope/vim-fugitive'}
```

This allows for more local user configuration beyond what's in the repo by default, which will eventually be converted to a simple "sane defaults" configuration and additional functionality provided by the `*.d/` directories

A full example of this can be seen here:
* `~/.config/nvim/lua/plugins.lua`:
```lua
-- ... line 1012, at the end of the main configuration function:
    Util.extraConfs("plugins.d") -- doesn't _have_ to be plugins.d, but makes it easier to keep track
-- ...
...
```

* `~/.config/nvim/lua/extra.lua`:
```
local use = require('packer').use

use { 'tpope/vim-fugitive'}
```
