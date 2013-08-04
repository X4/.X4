#########################################
# Delegate Global Configuration
#########################################

for file in $HOME/.X4/config/**/*.zsh; do
  source $file
done

#########################################
# Set Shell Theme
#########################################
if [[ -e $HOME/.zsh_theme ]]; then
  source $HOME/.zsh_theme
fi

#########################################
# Load Plugin Bundles
#########################################

for bundle in $HOME/.X4/bundle/*; do
  test -d $bundle && bundle=$bundle/${bundle##*/}.zsh
  test -f $bundle && source $bundle
done

#########################################
# Define Shell Functions
#########################################
for file in $HOME/.X4/func.d/*.zsh; do
  source $file
done

#########################################
# Set Shell Aliases
#########################################
for file in $HOME/.X4/alias.d/*.zsh; do
  source $file
done

#########################################
# Custom ZSH Settings
#########################################
if [[ -e $HOME/.zsh_custom ]]; then
  source $HOME/.zsh_custom
fi


