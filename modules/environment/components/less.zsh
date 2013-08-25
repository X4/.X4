#
# Less
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   J. Brandt Buckley <brandt@runlevel1.com>
#

# Set the default Less options.
# Note: Mouse-wheel scrolling is disabled.
#       To enable it, remove:
#         -X   (disable screen clearing)
#         -F   (exit if the contents fit on one screen)
# export LESS='-g -i -M -R -J -j5' # My original config
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

# These options are made possible because of termcap
# For information, see: http://linux.die.net/man/5/termcap  
if zstyle -t ':zcontrol:environment:termcap' color; then

  export LESS_TERMCAP_mb=$(tput blink; tput bold; tput setaf 2)   # Blink mode: blink, bold, green
  export LESS_TERMCAP_md=$(tput bold; tput setaf 6)               # Bold mode: bold, cyan
  export LESS_TERMCAP_me=$(tput sgr0)                             # Turn off all
  export LESS_TERMCAP_so=$(tput bold;tput setaf 89;tput setab 7)  # Standout mode: white on magenta
  export LESS_TERMCAP_se=$(tput rmso; tput sgr0)                  # Exit standout mode
  export LESS_TERMCAP_us=$(tput smul; tput setaf 7)               # Underline mode: underline, white
  export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)                  # Exit underline mode
  export LESS_TERMCAP_mr=$(tput rev)                              # Reverse
  export LESS_TERMCAP_mh=$(tput dim)                              # Dim mode
  export LESS_TERMCAP_ZN=$(tput ssubm)                            # Subscript mode
  export LESS_TERMCAP_ZV=$(tput rsubm)                            # Exit Subscript mode
  export LESS_TERMCAP_ZO=$(tput ssupm)                            # Superscript mode
  export LESS_TERMCAP_ZW=$(tput rsupm)                            # Exit Superscript mode
  export LESS_TERMCAP_ZH=$(tput sitm)                             # Italics mode
  export LESS_TERMCAP_ZR=$(tput ritm)                             # Exit italics mode
  
  export LESS_TERMCAP_zzz=$(tput sgr0)                            # Don't leave a mess when using `export`
                                                                  # or `set` (not a real termcap option)
fi