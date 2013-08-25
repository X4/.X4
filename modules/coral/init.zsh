#
# Coral: "The hacker's toolbelt for Ruby, gems, Bundler, git, and more"
#
# Requires:
#  - Packages:
#      Homebrew
#      git
#      ack
#      asciidoc
#      curl
#  - Gems:
#      bundler
#      Redcloth
#      github-markup
#      html-pipeline
#      rdoc
#
# Website:
#   https://github.com/mislav/coral
#
# Authors:
#   J. Brandt Buckley <brandt@runlevel1.com>
#

# Coral requires Homebrew, so Mac OS X is required.
if [[ "$OSTYPE" != darwin* ]]; then
  return 1
fi

# We install into a non-standard location:
CORAL_ROOT="$HOME/.local/coral"

# Add the Coral path.
path=( "$CORAL_ROOT/bin" $path )

# If Coral's directory doesn't exist, install it.
if [ ! -d "$CORAL_ROOT" ]; then
  git clone git://github.com/mislav/coral.git "$CORAL_ROOT" || {
    echo "Error: Unable to fetch Coral." >&2
    return 1
  }
  eval "$(coral doctor -s)"
fi

# Initialize into the current shell
# - Also adds ZSH completion.
eval "$(coral init -)"