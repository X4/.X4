#
# Enables local Haskell package installation.
#
# Authors:
#   Sebastian Wiesner <lunaryorn@googlemail.com>
#   J. Brandt Buckley <brandt@runlevel1.com>
#

# Return if requirements are not found.
if (( ! $+commands[ghc] )); then
  return 1
fi

# Prepend Cabal per user directories to PATH/MANPATH.
if [[ "$OSTYPE" == darwin* && -d "$HOME/Library/Haskell" ]]; then
  path=( $HOME/Library/Haskell/bin(/N) $path )
else
  path=( "${CABAL_CONFIG:-"$XDG_CONFIG_HOME/cabal"}"/bin(/N) $path )
fi