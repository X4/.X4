#
# MCO (MCollective) ZSH Module
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

# Add zsh-completions to $fpath for mcollective.
fpath=("${0:h}/external" $fpath)