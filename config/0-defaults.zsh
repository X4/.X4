# Lines configured by zsh-newuser-install
bindkey -e			# Use emacs-like key bindings by default:
setopt notify			# report the status of backgrounds jobs immediately
setopt nonomatch		# try to avoid the 'zsh: no matches found...'
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename ~/.zshrc
autoload -Uz compinit
compinit
# End of lines added by compinstall

# stuff from default oh-my-zsh configuration
setopt alwaystoend
setopt auto_cd			# Perform the cd command to that directory if it can't be accessed otherwise
setopt autopushd		# make cd push the old directory onto the directory stack.
setopt cdablevars
setopt completeinword		# not just at the end
setopt correctall
setopt extended_glob		# in order to use #, ~ and ^ for filename generation grep word  *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files  don't forget to quote '^', '~' and '#'!
setopt noflowcontrol
setopt interactive
setopt kshglob
setopt longlistjobs		# display PID when suspending processes as well
setopt monitor
setopt promptsubst		# Parameter Expansion for the prompt
setopt pushdignoredups
setopt noshwordsplit		# Use zsh style word splitting
setopt nobeep			# Avoid "beep"ing
setopt noglobdots		# * shouldn't match dotfiles. ever.
setopt hash_list_all		# whenever a command completion is attempted, make sure the entire command path is hashed first.

# remove HEAD^ escaping madness
unsetopt nomatch
