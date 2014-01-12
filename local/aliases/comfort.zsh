  alias dt='date "+%F %T"'
  alias cal="cal -m -3"
  alias open="xdg-open"
  alias o="xdg-open"
  alias x='exit'
  alias n='nano'
  alias dl="curl -O"
  alias puts='print -l'
  alias grep='grep --color'
  alias cmx="chmod +x "
  alias gdb="gdb -q"
  alias bc="bc -q -l ~/.bcrc"
  alias kate='kate >/dev/null 2>&1'
  alias mounts="mount | column -t"
  alias empty="clear && history --clear"
  alias duff="du -hd 1 | sort -h"
  alias release="lsb_release -a;echo;cat /etc/*release;echo; cat /etc/issue*"

# Reload config and reset bogus terminal
  alias cls=" clear;exec $SHELL"
# Download youtube playlist and convert to mp3
  alias yt="youtube-dl --ignore-errors --get-title --get-url --get-filename --restrict-filenames -x --audio-quality 7 --audio-format \"mp3\" -o \"%(title)s.%(ext)s\" "