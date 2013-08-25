#
# xorg - alternate path to components of the X Window System (X.org)
#

# See: http://www.faqs.org/faqs/Xt-FAQ/section-21.html

## Contains X authorization data (default: ~/.Xauthority)
export XAUTHORITY="$(dotfile xorg data file Xauthority)"

## The base directory for a users application dependent resource files (default: $HOME)
export XAPPLRESDIR="$(dotfile xorg config)"

## Per-host X resources defaults file (default: ~/.Xresources-<hostname>)
## Consulted each time an X app starts
export XENVIRONMENT="$(dotfile xorg config file Xresources)"