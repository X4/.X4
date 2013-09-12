#########################################
# Initiate ZSH configuration
#########################################
for file in $HOME/.X4/global/zsh/*.zsh; do
  source $file
done

for file in $HOME/.X4/local/zsh/*.zsh; do
  xsource $file
done

#########################################
# Set Shell Theme
#########################################
if [[ -e $HOME/.X4/global/themes ]]; then
  source $HOME/.X4/global/themes/$ZSH_PROMPT.zsh
fi

#########################################
# Load external ZSH Bundles
#########################################
for bundle in $HOME/.X4/bundle/*; do
  test -d $bundle && bundle=$bundle/${bundle##*/}.zsh
  test -f $bundle && source $bundle
done

#########################################
# Define Shell Functions
#########################################
for file in $HOME/.X4/global/functions/*.zsh; do
  source $file
done

for file in $HOME/.X4/local/functions/*.zsh; do
  xsource $file
done

#########################################
# Set Shell Aliases
#########################################
for file in $HOME/.X4/global/aliases/*.zsh; do
  source $file
done

for file in $HOME/.X4/local/aliases/*.zsh; do
  xsource $file
done

#########################################
# Custom ZSH Settings
#########################################
if [[ -e $HOME/.zprofile ]]; then
  source $HOME/.zprofile
fi