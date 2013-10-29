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
# Safer commands that check for x-istence
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

# Checks if a command exists and returns either true or false.
# Usage: xcmnd [-c|-g] word
#   -c  only checks for external commands
#   -g  does the usual tests and also checks for global aliases
function xcmd() {
    emulate -L zsh
    local -i command deep

    if [[ $1 == '-c' ]] ; then
        (( command = 1 ))
        shift
    elif [[ $1 == '-g' ]] ; then
        (( deep = 1 ))
    else
        (( command = 0 ))
        (( deep = 0 ))
    fi

    if (( ${#argv} != 1 )) ; then
        printf 'usage: xcmnd [-c] <command>\n' >&2
        return 1
    fi

    if (( command > 0 )) ; then
        [[ -n ${commands[$1]}  ]] && return 0
        return 1
    fi

    if   [[ -n ${commands[$1]}    ]] \
      || [[ -n ${functions[$1]}   ]] \
      || [[ -n ${aliases[$1]}     ]] \
      || [[ -n ${reswords[(r)$1]} ]] ; then

        return 0
    fi

    if (( gatoo > 0 )) && [[ -n ${galiases[$1]} ]] ; then
        return 0
    fi

    return 1
}

# Check if the underlying OS is a Darwin
function xdarwin(){
    [[ $OSTYPE == darwin* ]] && return 0
    return 1
}

# Check if the underlying OS is a Unix
function xfreebsd(){
    [[ $OSTYPE == freebsd* ]] && return 0
    return 1
}

# Check if the underlying OS is a Linux
function xlinux(){
    [[ $OSTYPE == linux* ]] && return 0
    return 1
}

# Check if the underlying OS is a Cygwin Environment
function xlinux(){
    [[ $OSTYPE == cygwin* ]] && return 0
    return 1
}
