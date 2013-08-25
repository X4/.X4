#
# git - alternate locations for git's dotfiles
#

# Git supports the XDG Base Directory Specification natively starting with Git v1.7.12
#
# Files:
#  ~/.config/git/config
#  ~/.config/git/ignore
#  ~/.config/git/attributes
#
# [Detailed in the Git release notes here.](http://git.io/oqu6Dw)
#

dotfile git config file config      >/dev/null
dotfile git config file attributes  >/dev/null
dotfile git config file ignore      >/dev/null

# Typical Migration Procedure:
#  cat ~/.gitconfig >! ${XDG_CONFIG_HOME}/git/config
#  cat $(git config --get core.excludesfile) >! ${XDG_CONFIG_HOME}/git/ignore
#  cat $(git config --get core.attributesfile) >! ${XDG_CONFIG_HOME}/git/attributes

# Then, to avoid conflicts, you'll need to reset a few options.
#  git config --global core.excludesfile ${(D)XDG_CONFIG_HOME}/git/ignore
#  git config --global core.attributesfile ${(D)XDG_CONFIG_HOME}/git/attributes
