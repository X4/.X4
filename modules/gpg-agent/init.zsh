#
# Provides for an easier use of gpg-agent.
#
# Authors:
#   Florian Walch <florian.walch@gmx.at>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   neersighted <neersighted@myopera.com>
#   J. Brandt Buckley <brandt@runlevel1.com>
#

# Return if requirements are not found.
if (( ! $+commands[gpg-agent] )); then
  return 1
fi

# Make sure to use the $GNUPGHOME first.
launchctl setenv "GNUPGHOME" "${GNUPGHOME:="$XDG_CONFIG_HOME/gnupg"}" &!
_gpg_env="$GNUPGHOME/gpg-agent.env"

function _gpg-agent-start {
  local ssh_support

  zstyle -b ':zcontrol:module:gpg-agent' ssh-support 'ssh_support' \
    || ssh_support=''

  gpg-agent \
    --daemon \
    ${ssh_support:+'--enable-ssh-support'} \
    --write-env-file "${_gpg_env}" > /dev/null

  chmod 600 "${_gpg_env}"
  source "${_gpg_env}" > /dev/null
}

# Source GPG agent settings, if applicable.
if [[ -s "${_gpg_env}" ]]; then
  source "${_gpg_env}" > /dev/null
  ps -ef | grep "${SSH_AGENT_PID}" | grep -q 'gpg-agent' || {
    _gpg-agent-start
  }
else
  _gpg-agent-start
fi

export GPG_AGENT_INFO
export SSH_AUTH_SOCK
export SSH_AGENT_PID
export GPG_TTY="$(tty)"