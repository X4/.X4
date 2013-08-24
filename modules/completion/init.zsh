#
# Sets completion options.

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

# Add zsh-completions to $fpath.
fpath=("${0:h}/external/src" $fpath)

# Setup zsh-completion styles
if [[ "$AUTO_COMPLETE" -eq 1 ]]; then
  # Source autocomplete style completions
  source "${0:h}/autocomplete.zsh"
  else
  # Source tabcomplete style completions
  source "${0:h}/tabcomplete.zsh"

fi

# Source keybindings.
source "${0:h}/keybindings.zsh"
