HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HIST_STAMPS="yyyy-mm-dd"
# append history list to the history file (required for share_history.)
setopt appendhistory
# save each command's beginning timestamp and the duration to the history file
setopt extendedhistory
# If a new command line being added to the history list duplicates an older one, the older command is removed from the list
setopt histignorealldups
setopt histignoredups
# remove from the history list when the first character on the line is a space
setopt histignorespace
setopt histverify
setopt incappendhistory
# import new commands from the history file also in other zsh-session
setopt sharehistory
# add `|' to output redirections in the history
setopt histallowclobber
# don't push the same dir twice.
setopt pushd_ignore_dups