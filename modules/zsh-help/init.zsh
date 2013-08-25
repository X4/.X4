#
# zsh-help - Easier browsing of the ZSH man page
#
# Author:
#  J. Brandt Buckley <brandt@runlevel1.com>

# If this variable is not set, bail.
if [ -z "${XDG_DATA_HOME}" ]; then
  return 1
fi

export HELPDIR="${XDG_DATA_HOME}/zsh/help"

# Auto-generate help files if they don't yet exist.
if [[ ! -d "${HELPDIR}" ]]; then
  echo "Generating ZSH built-in help files..." >&2
  mkdir -p "${HELPDIR}"
  ( cd "${HELPDIR}" && man zshbuiltins | colcrt - | ${0:h}/external/helpfiles )
fi

# Remove the defualt alias of 'run-help' to 'man'
unalias run-help
autoload run-help
autoload run-help-git
autoload run-help-sudo
autoload run-help-openssl
autoload run-help-svn
autoload run-help-svk

# Alias the `help` command to `run-help`
alias help='run-help'
