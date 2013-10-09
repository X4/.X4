#########################################
# Defines environment variables and global helpers.
#
# WARNING: Avoid modifying this file.
# Modify 'zshrc.local, zlogin, zlogout or zprofile' instead.
#########################################

#########################################
# Debugging helpers
#########################################
# setopt SOURCE_TRACE
# setopt XTRACE


#########################################
# Sanitize paths
#########################################
typeset -gx cdpath fpath mailpath path
typeset -gx MANPATH manpath
typeset -gx INFOPATH infopath
typeset -gx XDG_CACHE_HOME XDG_DATA_HOME XDG_CONFIG_HOME

# Bin Paths

## Set the main directories that Zsh searches for programs.
## - User paths (i.e. ~/.bin) are added again in 'zshrc' to ensure they're first.
path=(
  $HOME/.bin
  $HOME/.local/{bin,sbin}
  $HOME/.gem/ruby/2.0.0/bin
  /usr/local/{bin,sbin}
  /usr/libexec
  /usr/{bin,sbin}
  /{bin,sbin}
  $path
)

# CD Paths

## Set the the list of directories that cd searches.
cdpath=(
  $cdpath
)


# Info Paths

## Set the list of directories that `info` searches for manuals.
infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)


# Man Paths

## Set the list of directories that `man` searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)


# Function Paths

## Set additional directories for ZSH to search for functions.
fpath=(
  $fpath
)

#########################################
# Safer sourcing and cat used in in zshrc
#########################################
# Check if we can read given files and source those we can.
function xsource() {
    if (( ${#argv} < 1 )) ; then
        printf 'usage: xsource FILE(s)...\n' >&2
        return 1
    fi

    while (( ${#argv} > 0 )) ; do
        [[ -r "$1" ]] && source "$1"
        shift
    done
    return 0
}

# Check if we can read a given file and 'cat(1)' it.
function xcat() {
    emulate -L zsh
    if (( ${#argv} != 1 )) ; then
        printf 'usage: xcat FILE\n' >&2
        return 1
    fi

    [[ -r $1 ]] && cat $1
    return 0
}
