# My dotfiles

Welcome to my dotfiles. Nothing amazing here, but you may like:

- [my nvim configuration](.config/nvim) (see also [tjdevries nvim
  config](https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim))
- [my config](.config/flavours) for
  [flavours](https://github.com/Misterio77/flavours) and helpful
  [taste](.local/bin/taste) script, which helps you discover flavours more
  easily
- [my rofi script](.config/rofi/scripts/main.lua)
- [my zsh helper functions](.config/zsh/funcs)

Pleasy keep in mind I wrote most of these dotfiles for *my* setup and therefore
they might not work for you out-of-the-box (there might be system dependencies
which I do not really document).

In case of any questions, feel free to raise an issue.

---

### TODO

- nvim
    - null-ls and lsp low workload setting
    - unique mappings for telescope file explorer
    - mapping for buffer deletion in telescope buffers
    - perhaps https://github.com/nvim-telescope/telescope-ui-select.nvim
    - jupyter ascending reliable cell identification
- rofi
    - bluetooth script
    - flash disks -- mounting
    - connected screens -- xrandr
    - colorpicker
- zsh
    - autocomplete for `activate-virtual-environment` function
- battery
    - notification
- xmonad
    - cabal xmonad install
    - xmonad man page
    - my xmonad utils package
    - sticky windows [discussion](https://mail.haskell.org/pipermail/xmonad/2007-May/000319.html)
    - xmobar haskell config like [here](https://codeberg.org/xmobar/xmobar/src/branch/master/etc/xmobar.hs)
    - system-dependent bar, dynamic
    - my dynamic plugin
    - bluetoothctl indication


### Undocumented changes

- Xmonad installed through cabal.

- cleaning ~: /etc/profile, /etc/bash.bashrc

```bash
alias vim="vim -u \"$HOME\"/.config/vim/vimrc"
export HISTFILE="$HOME"/.config/bash/.bash_history
```

- cleaning ~: /etc/zsh/zshenv

```zsh
export ZDOTDIR="$HOME"/.config/zsh
```

