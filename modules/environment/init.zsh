#
# Sets general shell options and defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Smart URLs
#

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#
# Date/Time
#
autoload -U zsh/datetime

#
# General
#
setopt NO_FLOW_CONTROL
setopt INTERACTIVE
setopt KSH_GLOB
setopt MONITOR
setopt CDABLE_VARS
setopt CORRECT_ALL
setopt PROMPTSUBST        # Parameter Expansion for the prompt
setopt NOBEEP             # Avoid "beep"ing
setopt NO_GLOB_DOTS       # Wildcard (*) shouldn't match dotfiles.
setopt NO_SH_WORDSPLIT    # Use zsh style word splitting
setopt BRACE_CCL          # Allow brace character class list expansion.
setopt COMBINING_CHARS    # Combine zero-length punctuation characters (accents)
                          # with the base character.
setopt RC_QUOTES          # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt MAIL_WARNING     # Don't print a warning message if a mail file has been accessed.

#
# Jobs
#

setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
setopt NOTIFY             # Report status of background jobs immediately.
setopt nonomatch          # Try to avoid the 'zsh: no matches found...'
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.
unsetopt nomatch          # Remove HEAD^ escaping madness


#
# Grep
#

if zstyle -t ':prezto:environment:grep' color; then
  export GREP_COLOR='37;45'
  export GREP_OPTIONS='--color=auto'
fi

#
# Termcap
#

if zstyle -t ':prezto:environment:termcap' color; then
  export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
  export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
  export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
  export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
  export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
  export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
  export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.
fi


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