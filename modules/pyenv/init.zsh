#
# Initializes Python version manager, pyenv
#
# Authors:
#   J. Brandt Buckley <brandt@runlevel1.com>
#

# Return if requirements are not found.
if (( ! $+commands[pyenv] )); then
  return 1
fi

eval "$(pyenv init -)"