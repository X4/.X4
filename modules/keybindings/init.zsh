#
# ZSH Keybindings
#

# emacs-like key bind, bindkey -L shows list, bindkey -e vi-like
bindkey -e

# bind special keys according to readline configuration
eval "$(sed -n 's/^\( *[^#][^:]*\):/bindkey \1/p' /etc/inputrc)"

# do not erase entire line when Control-U is pressed
bindkey '^U' backward-kill-line

# make ^W stop at non-alphanumeric characters
autoload -U select-word-style
select-word-style bash

# edit the command line in your favorite editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

## use the vi navigation keys (hjkl) besides cursor keys in menu completion
bindkey -M menuselect 'h' vi-backward-char        # left
bindkey -M menuselect 'k' vi-up-line-or-history   # up
bindkey -M menuselect 'l' vi-forward-char         # right
bindkey -M menuselect 'j' vi-down-line-or-history # bottom

# backward delete
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

# Word skipping
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Do history expansion on space
bindkey ' ' magic-space

# let zsh infer next-hist-item completion
bindkey -M menuselect '^o' accept-and-infer-next-history

# Incremental Pattern Supported search
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

 
