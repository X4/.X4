zmodload zsh/complist
autoload -U compinit && compinit

# Use eight bit characters for completions
PRINT_EIGHT_BIT=1

# Enable cache - Some functions, like _apt and _dpkg, are very slow. You can use a cache in
# order to proxy the list of results (like the list of available debian packages)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.cache/zsh

# Enable completion database refreshes
#zstyle ':completion:::::' completer _complete _approximate
#_force_rehash() {
#  (( CURRENT == 1 )) && rehash
#  return 1	# Because we didn't really complete anything
#}
#zstyle ':completion:::::' completer _force_rehash _complete _approximate

# Enable verbose completions (similar to fish shell)
zstyle ':completion:*' extra-verbose true

# Enable menu selection
# http://www.masterzen.fr/tag/linux/
zstyle ':completion:*' menu select



# Prevent CVS files/directories from being completed
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

# Prevent commands like `rm'. It's annoying if one gets offered the same filename
# again even if it is already on the command line. To avoid that:
zstyle ':completion:*:rm:*' ignore-line yes



# Adjust TAB-completion of partial file names or paths
# http://www.rayninfo.co.uk/tips/zshtips.html
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Adjust mismatch handling
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'

# Adjust match count style
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Adjust corrections styles
zstyle ':completion:*:corrections' format "- %d - (errors %e})"

# Adjust description styles
#zstyle ':completion:*:descriptions' format "- %d -"

# Adjust grop-name style
zstyle ':completion:*' group-name ''




# Complete manpages - display seperate sections
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# manpage comletion
man_glob () {
  local a
  read -cA a
  if [[ $a[2] = -s ]] then
  reply=( ${^manpath}/man$a[3]/$1*$2(N:t:r) )
  else
  reply=( ${^manpath}/man*/$1*$2(N:t:r) )
  fi
}
compctl -K man_glob -x 'C[-1,-P]' -m - 'R[-*l*,;]' -g '*.(man|[0-9nlpo](|[a-z]))' + -g '*(-/)' -- man

# Tools - host completion for a few commands
compctl -k hosts ftp lftp ncftp ssh w3m lynx links elinks nc telnet rlogin host
compctl -k hosts -P '@' finger



# Shit I forgot what that was for..
#bindkey "^[[3~" delete-char
