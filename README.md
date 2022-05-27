# config.nvim

Personal nvim distro

## Install

```
git clone https://github.com/distek/config.nvim.git ~/.config/nvim
```

Then:
* run `nvim`
* run `:PackerInstall` in `nvim`
* close `nvim` and reopen to let TreeSitter compile it's parsers

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

Change them.
