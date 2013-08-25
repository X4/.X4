#
# pylint - python code static checker alternet dotfiles
#

# Previously ~/.pylintrc
export PYLINTRC="$(dotfile pylint config file pylintrc)"

# Previously ~/.pylint.d/
# Note: This is generated over the course of previous runs. It can usually be safely deleted.
export PYLINTHOME="$(dotfile pylint data dir pylint.d)"