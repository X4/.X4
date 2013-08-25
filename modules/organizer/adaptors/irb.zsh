#
# irb - alternate path to the irb dotfiles
#

# Creating a file at ~/.config/irb/irbrc
export IRBRC="$(dotfile irb config file irbrc)"

# Creating alternate IRB history file (not variables natively respected by IRB)
irb_history="$(dotfile irb data file irb_history)"

## Populate the default IRBRC file. (Only if it's empty.)
if [ ! -s "$IRBRC" ]; then
  printf '%s\n'  \
    "require 'irb/ext/save-history'"  \
    "# Required for alternate dotfile location to work:"  \
    "IRB.conf[:SAVE_HISTORY] = 2000" \
    "IRB.conf[:HISTORY_FILE] = \"#{ENV['HOME']}/${irb_history#$HOME/}\"" > $IRBRC
fi