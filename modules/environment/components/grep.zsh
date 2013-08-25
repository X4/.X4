#
# Grep
#

if zstyle -t ':zcontrol:environment:grep' color; then
  export GREP_COLOR="$(tput setab 5;tput bold;tput setaf 7)"  # white text on salmon
  export GREP_OPTIONS='--color=auto'
fi
