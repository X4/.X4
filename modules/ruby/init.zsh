#
# Configures Ruby local gem installation, loads version managers, and defines
# aliases.
#
# Requires:
#  - Packages:
#      ruby
#      rbenv (optional)
#      rvm (optional)
#      asciidoc
#      curl
#  - Gems:
#      bundler (optional)
#
# Authors: 
#  Sorin Ionescu <sorin.ionescu@gmail.com>
#  J. Brandt Buckley <brandt@runlevel1.com>
#

# Return if requirements are not found.
if (( ! $+commands[ruby] )); then
  return 1
fi

if (( $+commands[rbenv] )); then
  eval "$(rbenv init - --no-rehash zsh)"           # Load package manager installed rbenv into shell session.
elif [[ -s "$HOME/.rbenv/bin/rbenv" ]]; then
  path+=("$HOME/.rbenv/bin")
  eval "$(rbenv init - --no-rehash zsh)"           # Load manually installed rbenv into shell session.
elif [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  unsetopt AUTO_NAME_DIRS                          # Auto-adding variable-stored paths to ~ list conflicts with RVM.
  source "$HOME/.rvm/scripts/rvm"                  # Load RVM into the shell session.
else
  if [[ "$OSTYPE" == darwin* ]]; then
    export GEM_HOME="$HOME/Library/Ruby/Gems/1.8"  # Install local gems per operating system conventions.
    path+=( "$GEM_HOME/bin" )
  fi
fi


#
# Aliases
#

# General
alias rb='ruby'

# Bundler
if (( $+commands[bundle] )); then
  alias rbb='bundle'
  alias rbbe='rbb exec'
  alias rbbi='rbb install --path vendor/bundle'
  alias rbbl='rbb list'
  alias rbbo='rbb open'
  alias rbbp='rbb package'
  alias rbbu='rbb update'
  alias rbbI='rbbi \
    && rbb package \
    && print .bundle       >>! .gitignore \
    && print vendor/bundle >>! .gitignore \
    && print vendor/cache  >>! .gitignore'
fi

