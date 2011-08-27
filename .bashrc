# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
#alias l='ls $LS_OPTIONS -lAahH'
#
# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Some aliases for convenience
alias hue='tar -cvf fdgr46.tar fdgr46 && gzip fdgr46.tar'
alias empty='clear && history -p'
alias get='curl -O '
alias h='ls -Alih' 
alias c='gcc -Wall -ansi -pedantic -g -o '
alias '...'='../..'
alias '....'='../../..'
alias git-sub='git submodule init && git submodule update'


# [[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm # Lokal install
[[ -s '/usr/local/rvm/scripts/rvm' ]] && source '/usr/local/rvm/scripts/rvm' # Global install
