#
# zsh-refresh
#
# Triggers a re-sourcing of the the ZSH init scripts and rehash whenver ZSH
# receives SIGUSR1
#
# Note: Usually the USR1 signal would kill ZSH, so be sure this module is
# loaded before attempting.

# Load dependencies.
pmodload 'helper'  # Needed for its declaration of LS_COLORS

add-zsh-trap USR1 zsh-refresh

alias reshell="pkill -USR1 -u $(id -u) zsh"

# Now, issuing `pkill -USR1 zsh` or the alias, `reshell` will make all your 
# terminal sessions source the RC files again and rehash.
