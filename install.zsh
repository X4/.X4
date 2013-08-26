#!/usr/bin/env zsh
#
# Sets up the initial configuration of Zcontrol
#

### BEGIN USER CONFIGURABLE SECTION ###

# Alternate ZSH dir (ZDOTDIR)
# - This roughly follows the XDG Base Directory Specification
# - NOTE: Single quotes are important here
ALT_ZDOTDIR='$HOME/.config/zsh'

REPO_URL='https://github.com/X4/.X4.git'
REPO_BRANCH='edge'

ZSH_BIN=$(command -v zsh)

### END USER CONFIGURABLE SECTION ###

#
# functions
#

## Color palette for notifications
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'
normal='\033[0m'


## Aliases for colors
notify="$cyan"
warn="$yellow"
suggest="$white"
fatal="$red"


## Print notification to STDERR
notification() {
  local color="$1" ; shift
  printf "=> $color%s$normal\n" "$@" >&2
}


## Write alternate $ZDOTDIR to /etc/zshenv
zdotdir_not_set_in_global_rc() {
  # Check if declaration is in the global /etc/zshenv already
  if sed -e 's/^[ \t]*//g;/^$/d;/^#/d' /etc/zshenv | grep "[ \t]*ZDOTDIR=\"$ALT_ZDOTDIR\"" &>/dev/null ; then
    notification "$notify" "ZDOTDIR is already set in /etc/zshenv - skipping..."
    return 1
  else
    return 0
  fi
}


## Check if $ZDOTDIR is already set.
zdotdir_not_set_in_environment() {
  ## Determine the path to $ZDOTDIR after variable expansion
  eval ALT_ZDOTDIR_EXPANDED=$ALT_ZDOTDIR
  if [ "${ZDOTDIR}" ]; then
    # ZDOTDIR is already being set somewhere...
    # Is it what we wanted?
    if [ "${ZDOTDIR}" != "${ALT_ZDOTDIR_EXPANDED}" ]; then
      # ZDOTDIR is not what we wanted...
      notification "$fatal" \
        'Error: $ZDOTDIR is already set, but not to what we wanted.' \
        " Wanted: $ALT_ZDOTDIR_EXPANDED" \
        " Got: $ZDOTDIR"
      notification "$suggest" \
        'Try doing one of the following:' \
        'A. Remove the existing $ZDOTDIR declaration.' \
        'B. Unset the $ALT_ZDOTDIR setting in this script.' \
        'C. Alter the $ALT_ZDOTDIR setting to match your existing $ZDOTDIR setting.'
      exit 1
    else
      notification "$notify" "ZDOTDIR is already set so we won't write it to the global RC file."
      return 1
    fi
  fi
}


## Write conditional $ZDOTDIR declaration to global rc file
write_alternate_zdotdir_to_zshenv() {
  notification "$notify" 'Writing $ZDOTDIR to to /etc/zshenv'
  sudo tee -a /etc/zshenv >/dev/null <<EOF
if [ -d "$ALT_ZDOTDIR" -o -L "$ALT_ZDOTDIR" ]; then
  ZDOTDIR="$ALT_ZDOTDIR"
fi
EOF
}


#
# main
#

## If it isn't set yet, put $ZDOTDIR in /etc/zshenv
if zdotdir_not_set_in_environment ; then
  if zdotdir_not_set_in_global_rc ; then
    write_alternate_zdotdir_to_zshenv
  fi
fi
  

## Set ZDOTDIR to our alternate variable
eval ZDOTDIR=$ALT_ZDOTDIR


## Create the path to ZDOTDIR in case it doesn't yet exist
if [ ! -e "$ZDOTDIR" ]; then
  notification "$notify" "Making directory: $ZDOTDIR"
  mkdir -p "$ZDOTDIR"
fi


if [ -e "$ZDOTDIR/runcoms/zcontrol" ]; then
  notification "$fatal" "Error: Cannot install Zcontrol because it's already there: $ZDOTDIR"
  notification "$suggest" "Please move your existing installation and try again." \
    "Be careful! Your custom RC files (like .zshrc) are inside Zcontrol: $ZDOTDIR/runcoms" \
    "So be sure to backup any changes you've made before deleting anything."
  exit 1
fi

## Clone Zcontrol into ZDOTDIR
notification "$notify" "Cloning Zcontrol into $ZDOTDIR"
hash git >/dev/null && /usr/bin/env git clone --recursive -b "$REPO_BRANCH" "$REPO_URL" "$ZDOTDIR" || {
  notification "$fatal" "Error: Git clone failed. Cannot continue."
  notification "$suggest" "This is usually because Git is not correctly installed."
  exit 1
}

## Create relative symlinks
### CD into $ZDOTDIR so that we can create relative symlinks to Zcontrol RC files
pushd "${ZDOTDIR}"
setopt EXTENDED_GLOB
for rcfile in runcoms/^README.md(.N); do
  if [ -e ".${rcfile:t}" ]; then
    notification "$warn" "Warning: Won't create link beecause file already exists: .${rcfile:t}"
  else
    ln -s "$rcfile" ".${rcfile:t}"
  fi
done
## Return to original directory
popd &>/dev/null

## Change the user's shell to ZSH
if [ "${SHELL:t}" != "zsh" ]; then
  notification "$notify" "Changing default shell for $USER to $ZSH_BIN"
  chsh -s "$ZSH_BIN"
fi

## Run ZSH to get the updated profile
notification "$notify" "Installation complete. Starting a new ZSH login session..."
${ZSH_BIN} --login
