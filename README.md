# config.nvim

Personal nvim distro

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
