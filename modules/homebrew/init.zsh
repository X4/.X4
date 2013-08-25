#
# Module for Homebrew - The Mac Package Manager
#

# Note: This module should be included early in case other modules rely on the programs it installs.

# Return if requirements are not found.
if [[ "$OSTYPE" != darwin* ]]; then
  return 1
fi

# The path at which homebrew is installed: (~/.local/homebrew)
BREW_PREFIX="${XDG_LOCAL_DIR}/homebrew"

# Add Homebrew executables to $PATH
path=(
  ${BREW_PREFIX}/bin
  ${BREW_PREFIX}/sbin
  ${BREW_PREFIX}/share/npm/bin
  ${BREW_PREFIX}/share/python
  $path
)

# Add Homebrew completions to ZSH's $fpath
fpath=(
  ${BREW_PREFIX}/share/zsh-completions
  $fpath
)

manpath=(
  ${BREW_PREFIX}/share/man
  $manpath
)

# Install Homebrew if it is not yet installed...
homebrew_installer "${BREW_PREFIX}"
rehash