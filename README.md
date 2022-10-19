# My dotfiles


## TODO

- rofi
    [ ] bluetooth script
    [ ] flash disks
    [ ] connected screens
- battery
    [ ] notification
- xmonad
    [ ] system-dependent bar, dynamic
    [ ] xmobar haskell config like [here](https://codeberg.org/xmobar/xmobar/src/branch/master/etc/xmobar.hs)
    [ ] my dynamic plugin
    [ ] bluetoothctl indication
- terminal
    [ ] find files whitelist -- too much crap listed
    [ ] find files to recognize extension (zathura for pdf, feh for pictures,
    nvim for anything else)
    [ ] find projects - find .git, if .tmux execute it
    [ ] find directories whitelist -- too much crap listed


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

