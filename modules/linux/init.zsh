#
# Defines Linux aliases and functions.
#
# Authors:
#   J. Brandt Buckley <brandt@runlevel1.com>
#

# Return if requirements are not found.
if [[ "$OSTYPE" != linux* ]]; then
  return 1
fi

#
# Aliases
#

# last
alias last='last -a'                                        # Last: Show full hostname

# ps
alias psall='ps auxwf'                                      # Print full commands with args in a tree