#
# bash - alternate files for Bash history and configuration
#

## Sourced when Bash loads.
## Loads the other files to provide a familiar structure
export BASH_ENV="$(dotfile bash config file init.sh)"

## Create the initialization file that loads all the others. (Only if it's empty.)
if [ ! -s "$BASH_ENV" ]; then
  # TODO: Should dynamically load these paths based on user XDG_* setting.
  printf '%s\n'  \
    'export HISTFILE="~/.local/share/bash/bash_history"'   \
    '. ~/.config/bash/bashrc'  \
    '. ~/.config/bash/bash_profile' > "$BASH_ENV"
fi

## Generate files sourced by init.sh that dodn't correspond to a Bash environmental variable.
dotfile bash data   file bash_history >/dev/null
dotfile bash config file bashrc       >/dev/null
dotfile bash config file bash_profile >/dev/null