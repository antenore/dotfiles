dotfiles
========

![Screenshot](data/plasma-i3-gaps_2nd-round_201908.png)

* i3-gaps + Plasma + compton
* [#1994 – Steampunk Wallpaper – 4000×2915](https://www.hdwallpaper.nu/wp-content/uploads/2015/02/229976.jpg)
* gruvbox color scheme
* Breeze Dark
* ranger, zsh, vim with Plug


## Description

I keep most of my dotfiles in sync with git on github. After I've tried different approaches,
I came across GNU stow, that makes things easier.

All the dotfiles and some of my scripts are organized inside folders that acts like packages.
Executing stow from the dotfile folder, it will create one link in the parent directory foreach
file, or folder, found inside the specified "package".

### Packages (folders)

Note that this is a work in progress!

- X
   - Xresources
   - xprofile
   - xscreensaver
   - xsession
   - Xcolors
- colors
   - solarized
- conky
   - .conkyrc
- init
   - .initrc
   - .inputrc
- scripts
   - bin
      - baraction.sh
      - dmenu-launch
      - dzencalendar
      - initscreen.sh
      - mute.sh
      - randline.sh
      - screenshot.sh
      - weather_icons.lua
- spectrwm
   - .spectrwm.conf
   - .spectrwm_fr_ch.conf
- top
   - .toprc
- urxvt
   - .urxvt
- vim
   - .vim
   - .vimrc
- zsh
   - .zshrc

## Installation

- Install [GNU Stow](http://www.gnu.org/software/stow/)

        i.e. sudo pacman -S stow

- Clone to ~/dotfiles, and enter the directory.

        cd ~/dotfiles

- Symlink the .file into place with stow (if the dotfiles folder is in the home directory).

        stow --ignore ".xsession" X colors conky init \
                                  scripts spectrwm    \
                                  top urxvt vim zsh          # I don't use .xession at the moment

## TODO

- Write a Makefile

## License

Based on Brian Partridge original work.

