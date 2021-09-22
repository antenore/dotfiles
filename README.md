dotfiles
========

![Screenshot](data/i3wm-reddit.png)

* [i3-gaps](https://www.github.com/Airblader/i3) + [i3 GNOME integration for 3.28.1](https://github.com/i3-gnome/i3-gnome/tree/3.28.1) + [yshui/picom](https://github.com/yshui/picom)
* Wallpaper: https://pxhere.com/en/photo/664086
* Colors: Almost everything generated with [Pywal](https://github.com/dylanaraps/pywal) and heavily modified.
* Icons a modified version of Papirus, to match the color scheme.
* ranger, zsh, vim/neovim, st, and tmux.


## Description

I keep most of my dotfiles in sync with git on github. After I've tried different approaches,
I came across GNU stow, that makes things easier.

All the dotfiles and some of my scripts are organized inside folders that acts like packages.
Executing stow from the dotfile folder, it will create one link in the parent directory foreach
file, or folder, found inside the specified "package".

## Installation

- Install [GNU Stow](http://www.gnu.org/software/stow/)

        i.e. sudo pacman -S stow

- Clone to ~/.dotfiles, and enter the directory.

        cd ~/.dotfiles

- Symlink the .file into place with stow (if the dotfiles folder is in the home directory).

        stow --ignore ".xsession" X colors conky init \
                                  scripts spectrwm    \
                                  top urxvt vim zsh          # I don't use .xession at the moment

## TODO

- Write a Makefile

