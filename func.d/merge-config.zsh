#########################################
# Merge Aliases for Simplicity
#########################################

function zsh_merge_shell_aliases() {
  echo "" > $HOME/.X4/config/zsh_config
  for file in $HOME/.X4/config/*.sh; do
    echo "" >> ../config/zsh_config
    cat $file >> ../config/zsh_config
  done
}