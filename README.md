# vimrc
vim configuration. Used with neovim.

## Installation

Clone into `~/.config/nvim` or place the `init.vim` file as `.vimrc` in `~`. It should
work with both vim and neovim.

Upon first run, vim-plug is setup and plugins get installed automatically.


## Notes

- Uses `fzf` with ripgrep, so you need to have `rg` in $PATH. Will check for it and complain.
- Sets `shell` to `ksh`, change this if you use a different one
