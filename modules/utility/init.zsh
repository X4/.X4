#
# Defines general aliases and functions.
#
# Authors:
#   Robby Russell <robby@planetargon.com>
#   Suraj N. Kurapati <sunaku@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   J. Brandt Buckley <brandt@runlevel.com>
#
#

# Load dependencies.
pmodload 'helper' 'spectrum'

# Correct commands.
setopt CORRECT

#
# Aliases
#

# Disable correction.
alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias ebuild='nocorrect ebuild'
alias gcc='nocorrect gcc'
alias gist='nocorrect gist'
alias grep='nocorrect grep'
alias heroku='nocorrect heroku'
alias ln='nocorrect ln'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias rm='nocorrect rm'
alias touch='nocorrect touch'

# Disable globbing.
alias fc='noglob fc'
alias find='noglob find'
alias ftp='noglob ftp'
alias history='noglob history'
alias locate='noglob locate'
alias rake='noglob rake'
alias rsync='noglob rsync'
alias scp='noglob scp'
alias sftp='noglob sftp'
alias yum='noglob yum'

# Define general aliases.
alias _='sudo'
alias b='${(z)BROWSER}'
alias cp="${aliases[cp]:-cp} -i"
alias e='${(z)VISUAL:-${(z)EDITOR}}'
alias ln="${aliases[ln]:-ln} -i"
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias mv="${aliases[mv]:-mv} -i"
alias p='${(z)PAGER}'
alias po='popd'
alias pu='pushd'
# alias rm="${aliases[rm]:-rm} -i"
alias type='type -a'
alias bd='popd'

# sudo
alias fu='sudo $( fc -ln -1)'         # Use instead of 'sudo !!'

# ls
if is-callable 'dircolors'; then
  # GNU Core Utilities
  alias ls='ls --group-directories-first'

  if zstyle -t ':zcontrol:module:utility:ls' color; then
    alias ls="$aliases[ls] --color=auto"
  else
    alias ls="$aliases[ls] -F"
  fi
else
  # BSD Core Utilities
  if zstyle -t ':zcontrol:module:utility:ls' color; then
    alias ls='ls -G'
  else
    alias ls='ls -F'
  fi
fi

alias l='ls -1A'         # Lists in one column, hidden files.
alias ll='ls -lh'        # Lists human readable sizes.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.
alias sl='ls'            # I often screw this up.

# Homogenize Mac OS X commands across other systems
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
  alias pbc='pbcopy'
  alias pbp='pbpaste'
else
  alias o='xdg-open'
  alias get='wget --continue --progress=bar --timestamping'

  if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  fi

  if (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi

# Resource Usage

## List disks human readable by default
alias df='df -kh'
alias du='du -kh'

## In SysV UNIX `killall` literally kills everything. This is a safety net.
if [[ $OSTYPE =~ solaris* ]] || [[ $OSTYPE =~ aix* ]]; then
  alias -g killall='echo "On this system killall literally kills everything. Try: pkill"'
fi


# Miscellaneous

## Serves a directory via HTTP.
alias http-serve='python -m SimpleHTTPServer'

## JSON prettifier
alias json="python -mjson.tool"

## Base64 Conversion
alias base64decode="base64 -D"
alias base64encode="base64"

## Date - print an ISO 8901 timestamp (2012-11-01T13:54:26-0800)
alias ts='date "+%Y-%m-%dT%H:%M:%S%z"'

## VIM - start in paste mode
alias vimp='vim -c "set paste"'

## dd - send a signal to `dd` that triggers a status report
case $OSTYPE in
  darwin*) alias dd-status='sudo pkill -INFO "^dd$"' ;;
   linux*) alias dd-status='sudo pkill -USR1 "^dd$"' ;;
esac



#
# Functions
#

# Makes a directory and changes to it.
function mkcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Changes to a directory and lists its contents.
function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pushes an entry onto the directory stack and lists its contents.
function pushdls {
  builtin pushd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pops an entry off the directory stack and lists its contents.
function popdls {
  builtin popd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Prints columns 1 2 3 ... n.
function slit {
  awk "{ print ${(j:,:):-\$${^@}} }"
}

# Finds files and executes a command on them.
function find-exec {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Displays user owned processes status.
function psu {
  ps -U "${1:-$USER}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

