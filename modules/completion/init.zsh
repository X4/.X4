#
# Sets completion options.
#
# Authors:
#   Robby Russell <robby@planetargon.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   J. Brandt Buckley <brandt@runlevel1.com>
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

# Load dependencies.
pmodload 'utility'         # Needed for its declaration of LS_COLORS

# Add submodule-based ZSH completions to $fpath
fpath+=("${0:h}/external/zsh-completions/src")
fpath+=("${0:h}/external/zshpwn")
fpath+=("${0:h}/external/zsh-compdef")

# Setup individual completion scripts
zstyle ':zcontrol:module:completion:individual' sources \
  'john'  'https://raw.github.com/magnumripper/JohnTheRipper/unstable-jumbo/run/john.zsh_completion' \
  'subl'  'https://raw.github.com/memborsky/dotfiles/subl-wrapper/zsh/functions/_subl'

zstyle ':zcontrol:module:completion:individual' directory "${0:h}/external/individual"

# Download and install individual completers
individual_completion

# Load and initialize the completion system ignoring insecure directories.
autoload -Uz compinit && compinit -i -d "${XDG_CACHE_HOME}/zsh/zcompdump"

# GNU Generic Completion
source ${0:h}/generic.zsh(.) /dev/null


#
# Options
#

setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt HASH_LIST_ALL       # Hash command path is first before running completion.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a succesive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.

# Treat these characters as part of a word.
WORDCHARS='_%'

# Use eight bit characters for completions
PRINT_EIGHT_BIT=1

#
# Caching
#

# Use caching to make completion for cammands such as dpkg and apt usable.
zstyle ':completion::complete:*'        use-cache           on
zstyle ':completion::complete:*'        cache-path          "${XDG_CACHE_HOME}/zsh"


#
# Styles
#


# Case-insensitive (all), partial-word, and then substring completion.
if zstyle -t ':zcontrol:module:completion:*' case-sensitive; then
  zstyle ':completion:*'                matcher-list        'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  setopt CASE_GLOB
else
  if [[ "$LANG" =~ "de" ]]; then
    zstyle ':completion:*'              matcher-list        'm:ss=ß m:ue=ü m:ue=Ü m:oe=ö m:oe=Ö m:ae=ä m:ae=Ä m:{a-zA-Zöäüa-zÖÄÜ}={A-Za-zÖÄÜA-Zöäü}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  else
    zstyle ':completion:*'              matcher-list        'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  fi
  unsetopt CASE_GLOB
fi
# Adjust case-insensitive completions for: (all),partial-word and then substring matches


# Group matches and describe.
zstyle ':completion:*:*:*:*:*'          menu                select
zstyle ':completion:*'                  list-colors         'reply=( "=(#b)(*$PREFIX)(?)*=00=$color[green]=$color[bg-green]" )'
zstyle ':completion:*'                  select-prompt       %SScrolling active: current selection at %P Lines: %m
zstyle ':completion:*'                  group-name          ''
zstyle ':completion:*:matches'          group               'yes'
zstyle ':completion:*:options'          description         'yes'
zstyle ':completion:*:options'          auto-description    '%d'
zstyle ':completion:*:corrections'      format              ' %F{green} ☛ %d (errors: %e) --%f'
zstyle ':completion:*'                  format              $'%F{white} ☛ %F{yellow}completing %F{yellow}❬❬%F{white} %B%d%b%%F{yellow} ❭❭'                        
zstyle ':completion:*:messages'         format              ' %F{purple} ☛ %d --%f'
zstyle ':completion:*:warnings'         format              ' %F{red} ☛ no matches found --%f'
zstyle ':completion:*:default'          list-prompt         '%S%M matches%s'
zstyle -e ':completion:*:-command-:*:commands'  list-colors 'reply=( '\''=(#b)('\''$words[CURRENT]'\''|)*-- #(*)=0=38;5;45=38;5;136'\'' '\''=(#b)('\''$words[CURRENT]'\''|)*=0=38;5;45'\'' )'

# Enable verbose completions (similar to fish shell)
zstyle ':completion:*'                  verbose             yes
zstyle ':completion:*'                  extra-verbose       true

# Enable command descriptions. Disable if too slow
#zstyle ':completion:*:-command-:*:'    verbose             true

# Prevent menu completion for ambiguous initial strings
zstyle ':completion:*'                  insert-unambiguous  true
zstyle ':completion:*:correct:*'        original            true

# Fuzzy match mistyped completions.
zstyle ':completion:*'                  completer         _complete _match _approximate
zstyle ':completion:*:match:*'          original          only
zstyle ':completion:*:approximate:*'    max-errors        1 numeric

# Prevent comp to glob the first part of the path to avoid partial globs. (Performance)
zstyle ':completion:*'                  accept-exact      '*(N)'

# Enable rehash on completion so new installed program are found automatically:
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1      # Because we didn't really complete anything
}
zstyle ':completion:::::'               completer         _force_rehash _complete _approximate

# Increase the number of errors based on the length of the typed word.
zstyle -e ':completion:*:approximate:*' max-errors      'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*'  tag-order       indexes parameters

# Directories
zstyle ':completion:*:default'          list-colors     ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*'           tag-order       local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu      yes select
zstyle ':completion:*:-tilde-:*'        group-order     'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*'                  squeeze-slashes true

# Enable . and .. as a completion
zstyle -e ':completion:*'               special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

# Enable .. as a completion
#zstyle ':completion:*' special-dirs ..

# History
zstyle ':completion:*:history-words'    stop            yes
zstyle ':completion:*:history-words'    remove-all-dups yes
zstyle ':completion:*:history-words'    list            false
zstyle ':completion:*:history-words'    menu            yes

# Environmental Variables
zstyle ':completion::*:(-command-|export):*'  fake-parameters  ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# Enable process lists completion, like the local web server details and host completion
zstyle ':completion:*:urls'             local 'www' '/var/www/' 'public_html'

# Populate hostname completion.
zstyle -e ':completion:*:hosts'   hosts  'reply=(
  ${=${=${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users'  ignored-patterns \
  adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
  dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
  hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
  mailman mailnull mldonkey mysql nagios \
  named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
  operator pcap postfix postgres privoxy pulse pvm quagga radvd \
  rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

# ... unless we really want to.
zstyle '*'  single-ignored  show

# Prevent CVS files/directories from being completed
zstyle ':completion:*:(all-|)files'     ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*'             ignored-patterns '(*/)#CVS'

# Prevent completion of backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns       '*\~'

# Prevent these filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files'   ignored-patterns  '*?.(o|c~|old|pro|zwc)' '*~'

# Don't complete unavailable commands.
zstyle ':completion:*:functions'        ignored-patterns  '(_*|pre(cmd|exec))'

# Prevent files to be ignored from zcompile
zstyle ':completion:*:*:zcompile:*'     ignored-patterns  '(*~|*.zwc)'


# Ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*'   ignore-line       other
zstyle ':completion:*:rm:*'               file-patterns     '*:all-files'

# Kill
zstyle ':completion:*:*:*:*:processes'    command           'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:*:kill:*:processes' list-colors       '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*'           menu              yes select
zstyle ':completion:*:*:kill:*'           force-list        always
zstyle ':completion:*:*:kill:*'           insert-ids        single

# Man
zstyle ':completion:*:manuals'            separate-sections true
zstyle ':completion:*:manuals.(^1*)'      insert-sections   true

# Media Players
zstyle ':completion:*:*:mpg123:*'         file-patterns     '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:mpg321:*'         file-patterns     '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:ogg123:*'         file-patterns     '*.(ogg|OGG|flac):ogg\ files *(-/):directories'
zstyle ':completion:*:*:mocp:*'           file-patterns     '*.(wav|WAV|mp3|MP3|ogg|OGG|flac):ogg\ files *(-/):directories'

# File sort order defaults to name (incl. when unset or invalid)
# `size' to sort them by the size of the file
# `links' to sort them by the number of links to the file
# `modification' or `time' or `date' to sort them by the last modification time
# `access' to sort them by the last access time
# `inode' or `change' to sort them by the last inode change time
# `reverse' to sort in decreasing order
# `name` to sort alphabetically by name
zstyle ':completion:*' file-sort name

# Mutt
if [[ -s "${XDG_CONFIG_HOME}/mutt/aliases" ]]; then
  zstyle ':completion:*:*:mutt:*'         menu              yes select
  zstyle ':completion:*:mutt:*'           users             ${${${(f)"$(<"${XDG_CONFIG_HOME}/mutt/aliases")"}#alias[[:space:]]}%%[[:space:]]*}
fi

# SSH/SCP/RSYNC
zstyle ':completion:*:(scp|rsync):*'      tag-order         'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*'      group-order       users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*'              tag-order         'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*'              group-order       users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host'   ignored-patterns  '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns  '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns  '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

