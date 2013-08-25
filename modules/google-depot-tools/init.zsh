#
# Module for Google Depot Tools
#

# Add Google Depot Tools executables to $PATH
path=(
  ${XDG_LOCAL_DIR}/google-depot-tools
  $path
)

# Add Google Depot Tools completions to ZSH's $fpath
fpath=(
  ${XDG_LOCAL_DIR}/google-depot-tools/zsh-goodies
  $fpath
)

export NACL_ROOT="${HOME}/Projects/NACL"

# Uncomment to install Google Depot Tools:
# ${0:h}/external/google-depot-tools-installer && rehash

# Uncomment to bootstrap Google Native Client
# ${0:h}/external/google-nacl-installer