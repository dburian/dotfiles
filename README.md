# My dotfiles


## TODO

- rofi
    - bluetooth script
    - flash disks
    - connected screens
- battery
    - notification
- xmonad
    - cabal xmonad install
    - xmonad man page
    - sticky windows [discussion](https://mail.haskell.org/pipermail/xmonad/2007-May/000319.html)
    - xmobar haskell config like [here](https://codeberg.org/xmobar/xmobar/src/branch/master/etc/xmobar.hs)
    - system-dependent bar, dynamic
    - my dynamic plugin
    - bluetoothctl indication


## Undocumented changes

Xmonad installed through cabal.

### Cleaning ~

- /etc/profile, /etc/bash.bashrc

```bash
alias vim="vim -u \"$HOME\"/.config/vim/vimrc"
export HISTFILE="$HOME"/.config/bash/.bash_history
```

- /etc/zsh/zshenv

```zsh
export ZDOTDIR="$HOME"/.config/zsh
```

