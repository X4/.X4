#
# Initializes Zcontrol.
#

## Note:  $ZDOTDIR needs to be set in: /etc/zshenv
# if [ -d "$HOME/.config/zsh" -o -L "$HOME/.config/zsh" ]; then
#  ZDOTDIR="$HOME/.config/zsh"
# fi

#
# Version Check
#

# Check for the minimum supported version.
min_zsh_version='4.3.10'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  print "zcontrol: $SHELL is too old. Requires $min_zsh_version or later." >&2
  return 1
fi
unset min_zsh_version


#
# Preflight
#

# Ensure all of the XDG directories that we'll be using exist.
# The values for these should already have been declared in '.zshenv' or earlier.
if [ ! -d "${XDG_CONFIG_HOME}/zsh" -o ! -d "${XDG_DATA_HOME}/zsh" -o ! -d "${XDG_CACHE_HOME}/zsh" ]; then
  mkdir -p "${XDG_CONFIG_HOME}/zsh" "${XDG_DATA_HOME}/zsh" "${XDG_CACHE_HOME}/zsh"
fi


#
# Module Loader
#

# Profiler (use with `zprof` to see shell resource usage)
# zmodload zsh/zprof

# Loads Zcontrol modules.
function pmodload {
  local modules_root="${ZDOTDIR}/modules"
  local -a pmodules
  local pmodule
  local pfunction_glob='^([_.]*|prompt_*_setup|README*)(.N:t)'

  # $argv is overridden in the anonymous function.
  pmodules=("$argv[@]")

  # Add functions to $fpath.
  fpath=(${pmodules:+${modules_root}/${^pmodules}/functions(/FN)} $fpath)

  function {
    local pfunction

    # Extended globbing is needed for listing autoloadable function directories.
    setopt LOCAL_OPTIONS EXTENDED_GLOB

    # Load Zcontrol functions.
    for pfunction in $modules_root/${^pmodules}/functions/$~pfunction_glob; do
      autoload -Uz "$pfunction"
    done
  }

  # Load Zcontrol modules.
  for pmodule in "$pmodules[@]"; do
    if zstyle -t ":zcontrol:module:$pmodule" loaded; then
      continue
    elif [[ ! -d "$modules_root/$pmodule" ]]; then
      print "$0: no such module: $pmodule" >&2
      continue
    else
      zstyle ":zcontrol:module:$pmodule" basepath "$modules_root/$pmodule"
      if [[ -s "$modules_root/$pmodule/init.zsh" ]]; then
        source "$modules_root/$pmodule/init.zsh"
      fi

      if (( $? == 0 )); then
        zstyle ":zcontrol:module:$pmodule" loaded 'yes'
      else
        # Remove the $fpath entry.
        fpath[(r)$modules_root/${pmodule}/functions]=()

        function {
          local pfunction

          # Extended globbing is needed for listing autoloadable function
          # directories.
          setopt LOCAL_OPTIONS EXTENDED_GLOB

          # Unload Zcontrol functions.
          for pfunction in $modules_root/$pmodule/functions/$~pfunction_glob; do
            unfunction "$pfunction"
          done
        }

        zstyle ":zcontrol:module:$pmodule" loaded 'no'
      fi
    fi
  done
}


#
# Zcontrol Initialization
#

# Source the Zcontrol configuration file.
if [ -s "${ZDOTDIR}/.zcontrol" ]; then
  source "${ZDOTDIR}/.zcontrol"
fi

# Disable color and theme in dumb terminals.
if [[ "$TERM" == 'dumb' ]]; then
  zstyle ':zcontrol:*:*' color 'no'
  zstyle ':zcontrol:module:prompt' theme 'off'
fi

# Load Zsh modules.
zstyle -a ':zcontrol:load' zmodule 'zmodules'
for zmodule ("$zmodules[@]") zmodload "zsh/${(z)zmodule}"
unset zmodule{s,}

# Autoload Zsh functions.
zstyle -a ':zcontrol:load' zfunction 'zfunctions'
for zfunction ("$zfunctions[@]") autoload -Uz "$zfunction"
unset zfunction{s,}

# Load Zcontrol modules.
zstyle -a ':zcontrol:load' pmodule 'pmodules'
pmodload "$pmodules[@]"
unset pmodules

