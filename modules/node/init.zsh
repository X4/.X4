#
# Loads the Node Version Manager and enables npm completion.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   J. Brandt Buckley <brandt@runlevel1.com>
#   Zeh Rizzatti <zehrizzatti@gmail.com>
#

# Load NVM into the shell session.
if [[ -s "${XDG_CONFIG_HOME}/nvm/nvm.sh" ]]; then
  source "${XDG_CONFIG_HOME}/nvm/nvm.sh"
fi

# Return if requirements are not found.
if (( ! $+commands[node] )); then
  return 1
fi

# Load NPM completion.
if (( $+commands[npm] )); then
  cache_file="${XDG_CACHE_HOME}/zsh/npm.zcomp.zsh"

  if [[ "$commands[npm]" -nt "$cache_file" || ! -s "$cache_file" ]]; then
    # npm is slow; cache its output.
    npm completion >! "$cache_file" 2> /dev/null
  fi

  source "$cache_file"
  unset cache_file
fi
