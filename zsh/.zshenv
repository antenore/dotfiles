#!/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
export XMODIFIERS="@im=none"

# https://blog.patshead.com/2011/04/improve-your-oh-my-zsh-startup-time-maybe.html
skip_global_compinit=1

# http://disq.us/p/f55b78
#setopt noglobalrcs

export SYSTEM=$(uname -s)

# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zshenv
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Home-made scripts
export PATH=$PATH:${HOME}/bin

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
. "$HOME/.cargo/env"
