#
# Integrates zsh-syntax-highlighting into Zcontrol.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Return if requirements are not found.
if ! zstyle -t ':zcontrol:module:syntax-highlighting' color; then
  return 1
fi

# Source module files.
source "${0:h}/external/zsh-syntax-highlighting.zsh"

# Set the highlighters.
zstyle -a ':zcontrol:module:syntax-highlighting' highlighters 'ZSH_HIGHLIGHT_HIGHLIGHTERS'

# If no highlighters set, use defaults:
if (( ${#ZSH_HIGHLIGHT_HIGHLIGHTERS[@]} == 0 )); then
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
fi

