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
bindkey "^[[3~" delete-char
# let zsh infer next-hist-item completion
bindkey -M menuselect '^o' accept-and-infer-next-history
