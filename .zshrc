# I keep the following just to avoid wizards
# Lines configured by zsh-newuser-install
setopt appendhistory autocd extendedglob
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
# End of lines added by compinstall


[[ `who am i` != *\) ]] && is_local=yes
 
case $TERM in rxvt*) TERM=rxvt-256color esac  # urxvt only, TERM value is not recognized
                                     # when logging on ssh servers
 
autoload colors; colors  # so we can use $fg / $bg
 
 
# Environment
# ===========
 
export EDITOR=vim
export PATH=~/bin:$PATH
export PAGER=less
 
 
# History
# =======
 
export HISTSIZE=100000  # huge history size
export SAVEHIST=100000  # save all history when quitting
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
bindkey '^[[7~' beginning-of-line  # origin
bindkey '^[[8~' end-of-line  # end
bindkey '^[Od' backward-word  # ctrl + left
bindkey '^[Oc' forward-word  # ctrl + right
bindkey '^[[3^' delete-word  # ctrl + del
bindkey '^[[3~' delete-char  # del
bindkey '^H' backward-delete-word  # ctrl + backspace == ctrl + h
 
# Xterm
#bindkey '^[[H' beginning-of-line  # origin
#bindkey '^[[F' end-of-line  # end
#bindkey '^[[1;5D' backward-word  # ctrl + left
#bindkey '^[[1;5C' forward-word  # ctrl + right
#bindkey '^[[3;5~' delete-word  # ctrl + del
#bindkey '^[[3~' delete-char  # del
#bindkey '^?' backward-delete-word  # ctrl + backspace == ctrl + h
 
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
 
setopt no_bg_nice  # do not nice bg processes

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bira"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github python)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#Keychain
keychain id_rsa
. ~/.keychain/`uname -n`-sh

# Default browser
export BROWSER=/usr/bin/firefox

unsetopt correct_all
setopt correct
alias aptitude="nocorrect aptitude"

export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin

# to have better support with Midori
export MOZ_PLUGIN_PATH="/usr/lib/mozilla/plugins"

# NO IPV6 for JAVA
export _JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true"
[[ -s /home/tmow/.rvm/scripts/rvm ]] && . /home/tmow/.rvm/scripts/rvm # This loads RVM into a shell session.

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
alias jump="ssh -tt zcabbi4s ssh -tt $1"

# KEEP MOTIVATED

randline.sh ~/Dropbox/ENFP-mot.txt
