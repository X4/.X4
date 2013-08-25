#
# Defines Mac OS X aliases and functions.
#
# Requires:
#  - Packages:
#      Homebrew
#      git
#      rlwrap
#      sipcalc
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   J. Brandt Buckley <brandt@runlevel1.com>
#

# Return if requirements are not found.
if [[ "$OSTYPE" != darwin* ]]; then
  return 1
fi

#
# Aliases
#

# Sort by CPU usage by default
alias top='top -o CPU'

# Change directory to the current Finder directory.
alias cdf='cd "$(pfd)"'

# Push directory to the current Finder directory.
alias pushdf='pushd "$(pfd)"'

# Client CLI utility for interacting with Airport (WiFi)
alias -g airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport'

# Start ScreenSaver (must be executed as the user with control of the screen due to Mach bootstrap contexts)
alias ScreenSaver='open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app'

# Hide/Unhide files in the Finder
alias -g hide-file="chflags hidden"
alias -g unhide-file="chflags nohidden"
  
# No `md5sum` on Mac OS X, so we emulate it with openssl
# alias -g md5sum='md5'
alias -g md5sum='openssl dgst -md5'
  
# No `tac` on Mac OS X, so we emulate it with `tail -r`
alias tac="tail -r"
  
# Convert Plists to XML on STDOUT
alias plcat="plutil -convert xml1 -o - "
alias plecho="plcat"

# Diff, but in a GUI (part of Xcode)
# Use with args: --left <file> --right <file>
alias filemerge="${XCODE_TOOLS}/FileMerge.app/Contents/MacOS/FileMerge"

# No ipcalc on Mac OS X, so we'll pretend with sipcalc (Install with: brew install sipcalc)
alias ipcalc="sipcalc"
  
# Clean up LaunchServices to remove duplicates in the "Open With" menu
alias lsregister="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister"
alias lscleanup="lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Wrap various commands' interactive mode if rlwrap is available.
# This allows us to use familiar readline behavior and preserve history.
if (( $+commands[rlwrap] )); then
  alias PlistBuddy='rlwrap PlistBuddy'
fi

#
# Functions
#

# Open files in Quick Look.
function ql {
  (( $# > 0 )) && qlmanage -p "$@" &> /dev/null
}

# Delete .DS_Store and __MACOSX directories.
function rm-osx-cruft {
  find "${@:-$PWD}" \( \
    -type f -name '.DS_Store' -o \
    -type d -name '__MACOSX' \
  \) -print0 | xargs -0 rm -rf
}

