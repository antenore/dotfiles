dotfiles
========

0. Disclaimer

The following instructions are based on the article of Bob Silverberg

http://tux.it/pB

1. Scope

I use this repo to syncronize configuration files between my *Linux/*BSD hosts.

The following are the steps to keep the "servers" in sync

2. Getting a Copy of the Repo onto Machine 2

2.1 Change to a directory in which you want to put your Git repo. E.g., 

cd ~/gitRepos

2.2 Clone your GitHub repo to this machine:

git clone git@github.com:antenore/dotfiles.git

2.3 Create a link of the config files

rm ~/.zshrc && ln -siv ~/gitRepos/dotfiles/{.zshrc,.vimrc} ~/

2.4 Grabbing changes from the GitHub Repo

cd ~/gitRepos/dotfiles
git pull origin master

NOTES:

   * Requirements

    - Install dzen from git
    - Install wicd and remove Network Manager

   * Installed plugins

    $HOME/.vim/autoload:
    pathogen.vim

    $HOME/.vim/bundle:
    python-mode
    vim-colors-solarized
    vim-commentary
    vim-powerline
    vim-repeat

    * Icons

     http://sourceforge.net/projects/stlarchicons/files/stlarch_icons-1.2.tar.gz 
