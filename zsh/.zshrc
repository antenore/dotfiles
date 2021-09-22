# zsh profiling
#zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
umask 022
# I keep the following just to avoid wizards
# Lines configured by zsh-newuser-install
setopt appendhistory autocd extendedglob
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
# End of lines added by compinstall


[[ `who am i` != *\) ]] && is_local=yes

#case $TERM in rxvt*) TERM=rxvt-unicode-256color esac    # urxvt only, TERM value is not recognized
                                                        # when logging on ssh servers

#autoload colors; colors  # so we can use $fg / $bg

# dir_colors

eval `dircolors ~/.dir_colors`
export CLICOLOR=1


# Environment
# ===========

export EDITOR=vim
export PATH=~/bin:/usr/local/bin:$(ruby -r rubygems -e "puts Gem.user_dir")/bin:$PATH
export PAGER=less

if [ -f /usr/bin/lsb-release ] ; then
    # Cannot works everywhere
    MYDIST=$(/usr/bin/lsb-release -is | tr "[:upper:]" "[:lower:]" | tr -d " ")
elif [ -f /usr/bin/lsb_release ] ; then
    MYDIST=$(/usr/bin/lsb_release -is | tr "[:upper:]" "[:lower:]" | tr -d " ")
fi

# History
# =======

export HISTSIZE=200000  # huge history size
export SAVEHIST=200000  # save all history when quitting
export HISTFILE=~/.zhistory  # in this file
setopt share_history  # share history between ttys
setopt hist_ignore_all_dups  # do not save a command twice
setopt hist_reduce_blanks  # save the command "echo   plop" as "echo plop"


# Completion
# ==========

autoload compinit; compinit

zstyle ':completion:*' menu yes select  # menu selection
zstyle ':completion:*' format "$fg_bold[grey]%d$reset_color"  # Categories
                                                              # format
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}  # List file colors
zstyle ':completion:*' group-name ''  # Display everything in groups

# Completers list
zstyle ':completion:*' completer _expand _complete _match _approximate

# Completion cache
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Fuzzy completion
zstyle ':completion:*' matcher-list '+m:{a-z}={A-Z} r:|[._-]=** r:|=**' '' '' \
    '+m:{a-z}={A-Z} r:|[._-]=** r:|=**'
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Do not suggest those users
zstyle -d users
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
    named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs backup  bind  \
    dictd  gnats  identd  irc  man  messagebus  postfix  proxy  sys  www-data \
    avahi Debian-exim hplip list cupsys haldaemon ntpd proftpd statd \
    dbus ftp hal http

# Do not complete already selected arguments
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes

# Nice kill completion
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors \
    '=(#b) #([0-9]#)*=0=01;31'


# Key mapping
# ===========

# To know the corresponding string of a key comination, press ctrl + v then the
# keys. This configuration is for rxvt terminal.

bindkey -e  # emacs style (-v for vi)
# rxvt
#bindkey '^[[7~' beginning-of-line  # origin
#bindkey '^[[8~' end-of-line  # end
#bindkey '^[Od' backward-word  # ctrl + left
#bindkey '^[Oc' forward-word  # ctrl + right
#bindkey '^[[3^' delete-word  # ctrl + del
#bindkey '^[[3~' delete-char  # del
#bindkey '^H' backward-delete-word  # ctrl + backspace == ctrl + h

# Xterm
#bindkey '^[[H' beginning-of-line  # origin
#bindkey '^[[F' end-of-line  # end
#bindkey '^[[1;5D' backward-word  # ctrl + left
#bindkey '^[[1;5C' forward-word  # ctrl + right
#bindkey '^[[3;5~' delete-word  # ctrl + del
#bindkey '^[[3~' delete-char  # del
#bindkey '^?' backward-delete-word  # ctrl + backspace == ctrl + h

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
[[ -n "${key[Backspace]}"   ]]  && bindkey  "${key[Backspace]}"   backward-delete-char


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Search history for a command beginning with the current input. It places the
# cursor at the beginning of the command line.
bindkey '^[[A' history-beginning-search-backward  # up
bindkey '^[[B' history-beginning-search-forward  # down

bindkey '^Z' push-input # stash the current input and pop it to the next
                        # command prompt

# Quick ../../..
rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey '.' rationalise-dot

# Add every paths accessed by cd to directory stack (pushd / popd). Allows to
# do "cd -1" to go back.
setopt auto_pushd pushd_minus pushd_ignore_dups pushd_silent pushd_to_home \
    auto_cd

setopt no_clobber  # disallow > redirections to an existing file
                   # ( >| to override)

setopt hash_cmds hash_dirs  # command list cache
# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
cmn_plugins=(encode64 fancy-ctrl-z git gpg-agent nmap
    sudo systemadmin zsh-interactive-cd zsh_reload)
case "$MYDIST" in
    fedora|redhat)
        plugins=(${cmn_plugins[@]} dnf)
        ;;
    arch)
        plugins=(${cmn_plugins[@]} archlinux)
        ;;
    ubuntu)
        plugins=(${cmn_plugins[@]} ubuntu)
        ;;
    *)
        # Not known (yet) distrib
        plugins=(${cmn_plugins[@]})
        ;;
esac

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#Keychain
#keychain id_rsa
#. ~/.keychain/`uname -n`-sh
#eval `keychain --eval --agents ssh,gpg id_rsa`

# Command line calculator
autoload -Uz zcalc

# Default browser
export BROWSER=/usr/bin/firefox

unsetopt correct_all
setopt correct

export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin

# to have better support with Midori
export MOZ_PLUGIN_PATH="/usr/lib/mozilla/plugins"

# NO IPV6 for JAVA
#export _JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
#export _JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
[[ -s /home/tmow/.rvm/scripts/rvm ]] && . /home/tmow/.rvm/scripts/rvm # This loads RVM into a shell session.

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# KEEP MOTIVATED

#randline.sh ~/Dropbox/ENFP-mot.txt
# Bettter and "built in"
#gshuf -n 1 ~/Dropbox/ENFP-mot.txt | cowsay
#   if which shuffle >/dev/null 2>&1 ; then
#       shuffle ~/Dropbox/ENFP-mot.txt | tail -1 | cowsay
#   elif which shuf >/dev/null 2>&1; then
#       shuf ~/Dropbox/ENFP-mot.txt | tail -1 | cowsay
#
#   fi

export RI="--format ansi --width 70"
export WINEARCH=win32
#wmname LG3D

PATH="~/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="~/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="~/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"~/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=~/perl5"; export PERL_MM_OPT;

#
#        _/_/_/_/  _/_/_/_/_/  _/_/_/_/
#       _/              _/    _/
#      _/_/_/        _/      _/_/_/
#     _/          _/        _/
#    _/        _/_/_/_/_/  _/
#
# source: ~/.fzf

if [ ! -d ~/.fzf ] ; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Modified version where you can press
#   - CTRL-O to open with `xdg-open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() (
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && xdg-open "$file" || ${EDITOR:-vim} "$file"
  fi
)

# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
# zsh autoload function
fv() {
  local files

  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     vim -- $files
     print -l $files[1]
  fi
}


#              _/          _/                    _/
#     _/_/_/  _/_/_/    _/_/_/_/        _/_/_/  _/_/_/
#  _/        _/    _/    _/          _/_/      _/    _/
# _/        _/    _/    _/              _/_/  _/    _/
#  _/_/_/  _/    _/      _/_/  _/  _/_/_/    _/    _/
#
# source: curl https://cht.sh/:cht.sh >| ~/bin/cht.sh

fpath=(~/.zsh.d/ $fpath)


source ~/.zshrc.local

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

