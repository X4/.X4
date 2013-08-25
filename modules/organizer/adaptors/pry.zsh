#
# pry - alternate path to the pry dotfiles
#

# Creating a file at ~/.config/irb/irbrc
#export PRYRC="$(dotfile pry config file pryrc)"

# Creating alternate Pry history file (not variables natively respected by Pry)
#pry_history="$(dotfile pry data file pry_history)"

## Populate the default IRBRC file. (Only if it's empty.)
#if [ ! -s "$PRYRC" ]; then
#  printf '%s\n'  \
#    "Pry.config.history.file = \"#{ENV['HOME']}/${pry_history#$HOME/}\"" > $IRBRC
#fi