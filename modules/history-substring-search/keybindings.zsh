#
# Key Bindings for history-substring-search
#

if [[ -n "$key_info" ]]; then
  # Emacs
  bindkey -M emacs "$key_info[Control]P" history-substring-search-up
  bindkey -M emacs "$key_info[Control]N" history-substring-search-down

  # Vi
  bindkey -M vicmd "k" history-substring-search-up
  bindkey -M vicmd "j" history-substring-search-down

  # Emacs and Vi
  for keymap in 'emacs' 'viins'; do
    bindkey -M "$keymap" "$key_info[Up]" history-substring-search-up
    bindkey -M "$keymap" "$key_info[Down]" history-substring-search-down
  done
fi

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$key_info[Control]$terminfo[kcuu1]" history-substring-search-up
bindkey "$key_info[Control]$terminfo[kcud1]" history-substring-search-down
#bindkey '\e[1;5A' history-substring-search-up
#bindkey '\e[1;5B' history-substring-search-down

# ... support zsh in tmux in URxvt too
if test "${TERM#screen}" != "$TERM"; then
  bindkey '\e[1;5A' history-substring-search-up
  bindkey '\e[1;5B' history-substring-search-down
fi


