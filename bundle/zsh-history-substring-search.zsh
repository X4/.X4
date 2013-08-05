if test "$TERM" != linux; then
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,standout'
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,standout'
fi #'fg=yellow,bold,standout'

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# ... support zsh in tmux in URxvt too
if test "${TERM#screen}" != "$TERM"; then
  bindkey '\e[1;5A' history-substring-search-up
  bindkey '\e[1;5B' history-substring-search-down
fi

# ctrl+arrow-up
bindkey '\e[1;5A' history-substring-search-up
# ctrl+arrow-down
bindkey '\e[1;5B' history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
