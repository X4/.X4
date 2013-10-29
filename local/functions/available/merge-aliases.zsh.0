#########################################
# Merge Aliases for Simplicity
#########################################

function zsh_merge_shell_aliases() {
  echo "" > $HOME/.X4/alias.d/all-aliases
  for file in $HOME/.X4/alias.d/*.sh; do
    cat $file >> ../alias.d/all-aliases
  done
}