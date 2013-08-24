#
# General ZSH Keybindings
#

# emacs-like key bind, bindkey -L shows list, bindkey -e vi-like
bindkey -e

# Bind special keys according to readline configuration
eval "$(sed -n 's/^\( *[^#][^:]*\):/bindkey \1/p' /etc/inputrc)"

# Make ^W stop at non-alphanumeric characters
autoload -U select-word-style
select-word-style bash

# Word skipping by ctrl+left/right
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Redefine clear-screen
bindkey '^l'  clear-screen

