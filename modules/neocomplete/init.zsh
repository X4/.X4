#
# Sets completion options.
#


# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

# Add zsh-completions to $fpath.
fpath=("${0:h}/external/src" $fpath)


# Load and initialize the completion system ignoring insecure directories.
zmodload zsh/complist
autoload -Uz compinit && compinit #-i
autoload -U colors ; colors

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


# Use eight bit characters for completions
PRINT_EIGHT_BIT=1


# determine in which order the names (files) should be listed and completed when using menu completion.
# `size' to sort them by the size of the file
# `links' to sort them by the number of links to the file
# `modification' or `time' or `date' to sort them by the last modification time
# `access' to sort them by the last access time
# `inode' or `change' to sort them by the last inode change time
# `reverse' to sort in decreasing order
# If the style is set to any other value, or is unset, files will be
# sorted alphabetically by name.
zstyle ':completion:*' file-sort name

# how many completions switch on menu selection
# use 'long' to start menu compl. if list is bigger than screen
# or some number to start menu compl. if list has that number
# of completions (or more).
zstyle ':completion:*' menu select=long

# If there are more than 5 options, allow selecting from a menu with
# arrows (case insensitive completion!).
zstyle ':completion:*-case' menu select=5




# Enable cache - Some functions, like _apt and _dpkg, are very slow. You can use a cache in
# order to proxy the list of results (like the list of available debian packages)
zstyle ':completion:*'			use-cache on
zstyle ':completion:*'			cache-path "${ZDOTDIR:-$HOME}/.zcompcache"

# Enable rehash on completion so new installed program are found automatically:
zstyle ':completion:::::'		completer _complete _approximate
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1	# Because we didn't really complete anything
}
zstyle ':completion:::::'		completer _force_rehash _complete _approximate

# Enable verbose completions (similar to fish shell)
zstyle ':completion:*'			extra-verbose true
# Enable verbose completion information
#zstyle ':completion:*'                 verbose true
# Enable command descriptions. Disable if too slow
#zstyle ':completion:*:-command-:*:'    verbose true

# Enable menu selection
# http://www.masterzen.fr/tag/linux/
zstyle ':completion:*:*:*:*:*'		menu select

# Enable history menu selection
zstyle ':completion:*:history-words'	menu yes

# Enable completion of 'cd -<tab>' and 'cd -<ctrl-d>' with menu
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

# Enable expand completer for all expansions
zstyle ':completion:*:expand:*'		tag-order all-expansions
zstyle ':completion:*:history-words'	list false

# Enable matches to separate into groups
zstyle ':completion:*:matches'		group 'yes'

# Enable processes completion for all user processes
zstyle ':completion:*:processes'	command 'ps -au$USER'

# Enable more processes in completion of programs like killall:
zstyle ':completion:*:processes-names'	command 'ps c -u ${USER} -o command | uniq'
zstyle ':completion:*:(killall|pkill|kill):*'	menu yes select
zstyle ':completion:*:(killall|pkill|kill):*'	force-list always

# Enable offering indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*'	tag-order indexes parameters

# Enable ~/userbane expansions
zstyle ':completion:*:-tilde-:*'	group-order 'named-directories' 'path-directories' 'users' 'expand'

# Enable . and .. as a completion
zstyle -e ':completion:*'		special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

# Enable only .. as a completion
#zstyle ':completion:*' special-dirs ..

# Enable environmental variable completion
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# Enable process lists completion, like the local web server details and host completion
zstyle ':completion:*:urls' 		local 'www' '/var/www/' 'public_html'

# Enable hostname completion (use /etc/hosts and known_hosts for hostname completion)
[ -r /etc/ssh/ssh_known_hosts ] && _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _global_ssh_hosts=()
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
  "$_global_ssh_hosts[@]"
  "$_ssh_hosts[@]"
  "$_etc_hosts[@]"
  "$HOST"
  localhost
)
zstyle ':completion:*:hosts' 		hosts $hosts

# Enable $ scp file username@<TAB><TAB>:/<TAB>
zstyle ':completion:*:(ssh|scp|ftp):*' hosts $hosts
zstyle ':completion:*:(ssh|scp|ftp):*' users $users

# Enable completions for some progs. not in default completion system
zstyle ':completion:*:*:mpg123:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:mpg321:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:ogg123:*' file-patterns '*.(ogg|OGG|flac):ogg\ files *(-/):directories'
zstyle ':completion:*:*:mocp:*' file-patterns '*.(wav|WAV|mp3|MP3|ogg|OGG|flac):ogg\ files *(-/):directories'


# Enable Autocomplete
zstyle ':completion:*' use-compctl false


# Prevent CVS files/directories from being completed
zstyle ':completion:*:(all-|)files'	ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*'		ignored-patterns '(*/)#CVS'

# Prevent commands like `rm'
zstyle ':completion:*:rm:*'		ignore-line yes

# Prevent menu completion for ambiguous initial strings
zstyle ':completion:*'			insert-unambiguous true
zstyle ':completion:*:corrections'	format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:correct:*'	original true

# Prevent men completion for duplicate entries
zstyle ':completion:*:history-words'	remove-all-dups yes
zstyle ':completion:*:history-words'	stop yes

# Prevent completion of functions for commands you don't have
zstyle ':completion:*:functions'	ignored-patterns '(_*|pre(cmd|exec))'

# Prevent files to be ignored from zcompile
zstyle ':completion:*:*:zcompile:*'	ignored-patterns '(*~|*.zwc)'
zstyle ':completion:correct:'		prompt 'correct to: %e'

#Prevent comp to glob the first part of the path to avoid partial globs. (Performance)
zstyle ':completion:*' accept-exact '*(N)'

# Prevent trailing slash if argument is a directory
zstyle ':completion:*'			squeeze-slashes true
zstyle ':completion::complete:*' '\\'

# Prevent completion of backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# Prevent these filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns  '*?.(o|c~|old|pro|zwc)' '*~'

# Prevent rm completion
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'


# Adjust case-insensitive completions for: (all),partial-word and then substring matches
zstyle ':completion:*' 			matcher-list 'm:ss=ß m:ue=ü m:ue=Ü m:oe=ö m:oe=Ö m:ae=ä m:ae=Ä m:{a-zA-Zöäüa-zÖÄÜ}={A-Za-zÖÄÜA-Zöäü}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Adjust mismatch handling - allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:*'    max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

# Adjust match count style
zstyle ':completion:*:default'		list-prompt '%S%M matches%s'

# Adjust selection prompt style
zstyle ':completion:*'			select-prompt %SScrolling active: current selection at %P Lines: %m

# Adjust color-completion style
zstyle ':completion:*:default'		list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*'			list-colors  'reply=( "=(#b)(*$PREFIX)(?)*=00=$color[green]=$color[bg-green]" )'

# Adjust completion to offer fish-style highlighting for extra-verbose command completion:
zstyle -e ':completion:*:-command-:*:commands'	list-colors 'reply=( '\''=(#b)('\''$words[CURRENT]'\''|)*-- #(*)=0=38;5;45=38;5;136'\'' '\''=(#b)('\''$words[CURRENT]'\''|)*=0=38;5;45'\'' )'

# Adjust corrections styles
zstyle ':completion:*:corrections' 	format "- %d - (errors %e)"
#or zstyle ':completion:*:corrections'	format $'%{\e[0;31m%}%d (errors: %e)%}'

# Adjust hosts style (background = red, foreground = black)
zstyle ':completion:*:*:*:*:hosts'	list-colors '=*=30;41'

# Adjust usernames style (background = white, foreground = blue)
zstyle ':completion:*:*:*:*:users'	list-colors '=*=34;47'

# Adjust description styles
zstyle ':completion:*:descriptions'	format $'%{\033[1m⚔\e[0;33m%} completing ☛\e[0m %B%d%b%{\e[0m%}'

# describe options in full
zstyle ':completion:*:options'		auto-description '%d'
zstyle ':completion:*:options'		description 'yes'
zstyle ':completion:*:messages'		format '%d'

# Adjust grop-name style
zstyle ':completion:*'			group-name ''

# Adjust warnings style
zstyle ':completion:*:warnings'		format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'




# Complete manpages - display seperate sections
# complete manual by their section
zstyle ':completion:*:manuals'		separate-sections true
zstyle ':completion:*:manuals.*'	insert-sections   true
#zstyle ':completion:*:manuals.(^1*)'	insert-sections   true
zstyle ':completion:*:man:*'		menu yes select

# Search path for sudo completion
zstyle ':completion:*:sudo:*'		command-path /usr/local/sbin \
					 /usr/local/bin  \
					 /usr/sbin       \
					 /usr/bin        \
					 /sbin           \
					 /bin            \
					 /usr/X11R6/bin

# SSH/SCP/RSYNC
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

					 

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

## correction
# some people don't like the automatic correction - so run 'NOCOR=1 zsh' to deactivate it
if [[ "$NOCOR" -gt 0 ]] ; then
    zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _files _ignored
    setopt nocorrect
else
    # try to be smart about when to use what completer...
    setopt correct
    zstyle -e ':completion:*' completer '
	if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
	    _last_try="$HISTNO$BUFFER$CURSOR"
	    reply=(_complete _match _ignored _prefix _files)
	else
	    if [[ $words[1] == (rm|mv) ]] ; then
		reply=(_complete _files)
	    else
		reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
	    fi
	fi'
fi
