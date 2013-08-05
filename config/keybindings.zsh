# Don't create newlines if no command is given
#accept-line () { [[ -z $BUFFER ]] && return;
#	zle .accept-line;
#};
#zle -N accept-line

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
